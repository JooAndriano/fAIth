import 'package:faith_mobile/core/routes/app_routes.dart';
import 'package:faith_mobile/core/theme/app_spacing.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:faith_mobile/features/ai/presentation/widgets/ai_debug_fab.dart';
import 'package:faith_mobile/features/bible/domain/models/passage.dart';
import 'package:faith_mobile/features/home/presentation/controllers/home_controller.dart';
import 'package:faith_mobile/features/home/presentation/widgets/home_sections.dart';
import 'package:faith_mobile/features/shell/presentation/controllers/shell_controller.dart';
import 'package:faith_mobile/shared/widgets/gradient_header.dart';
import 'package:faith_mobile/shared/widgets/highlight_card.dart';
import 'package:faith_mobile/shared/widgets/state_views.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Beranda tab: greeting, encouragement verse, verse of the day, today's
/// devotional, shortcuts and the nearest church.
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  void _openTab(ShellTab tab) => Get.find<ShellController>().select(tab);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: kDebugMode ? const AiDebugFab() : null,
      body: RefreshIndicator(
        onRefresh: controller.load,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GradientHeader(
              subtitle: '${controller.greeting},',
              title: controller.firstName,
              trailing: HomeAvatar(
                user: controller.user,
                onTap: () => Get.toNamed<void>(AppRoutes.profile),
              ),
              child: EncouragementCard(
                child: Obx(
                  () => InlineStateView<Passage>(
                    state: controller.encouragement.value,
                    onRetry: controller.loadEncouragement,
                    minHeight: 56,
                    empty: const _NoDefaultVerse(),
                    builder: (_, passage) => PassageText(passage: passage, onHeader: true),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HighlightCard(
                    icon: Icons.menu_book_outlined,
                    label: 'Ayat Hari Ini',
                    child: Obx(
                      () => InlineStateView<Passage>(
                        state: controller.verseOfDay.value,
                        onRetry: controller.loadVerseOfDay,
                        builder: (_, passage) => PassageText(passage: passage),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Obx(
                    () => InlineStateView(
                      state: controller.todayDevotional.value,
                      onRetry: controller.loadDevotional,
                      builder: (_, devotional) => DevotionalSummaryCard(
                        devotional: devotional,
                        onTap: () => Get.toNamed<void>(
                          AppRoutes.devotional,
                          arguments: devotional.id,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: QuickActionTile(
                            icon: Icons.chat_bubble_outline,
                            title: 'Tanya fAIth',
                            subtitle: 'Ngobrol seputar iman',
                            emphasized: true,
                            onTap: () => _openTab(ShellTab.chat),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: QuickActionTile(
                            icon: Icons.edit_note,
                            title: 'Jurnal Doa',
                            subtitle: 'Tulis doamu',
                            onTap: () => _openTab(ShellTab.prayer),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ChurchTeaserCard(
                    onTap: () => Get.toNamed<void>(AppRoutes.churches),
                    body: Obx(
                      () => InlineStateView(
                        state: controller.nearestChurch.value,
                        onRetry: controller.loadChurch,
                        minHeight: 48,
                        empty: Text(
                          'Belum ada gereja di sekitarmu.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        builder: (_, church) => ChurchRow(church: church),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Encouragement fallback when the user has no default favorite verse.
class _NoDefaultVerse extends StatelessWidget {
  const _NoDefaultVerse();

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    return InkWell(
      onTap: () => Get.toNamed<void>(AppRoutes.favoriteVerses),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Pilih ayat favorit sebagai penguat harianmu.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: faith.onHeaderMuted),
            ),
          ),
          Icon(Icons.chevron_right, color: faith.gold),
        ],
      ),
    );
  }
}
