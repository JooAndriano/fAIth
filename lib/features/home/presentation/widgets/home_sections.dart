import 'package:faith_mobile/core/theme/app_radius.dart';
import 'package:faith_mobile/core/theme/app_spacing.dart';
import 'package:faith_mobile/core/theme/faith_colors.dart';
import 'package:faith_mobile/features/auth/domain/app_user.dart';
import 'package:faith_mobile/features/bible/domain/models/passage.dart';
import 'package:faith_mobile/features/churches/domain/models/church.dart';
import 'package:faith_mobile/features/devotional/domain/models/devotional.dart';
import 'package:faith_mobile/shared/widgets/faith_card.dart';
import 'package:flutter/material.dart';

/// Avatar with photo or initial, shown in the Beranda header.
class HomeAvatar extends StatelessWidget {
  const HomeAvatar({super.key, required this.user, required this.onTap});

  final AppUser? user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    final photo = user?.photoUrl;
    return Tooltip(
      message: 'Profil',
      child: InkResponse(
        onTap: onTap,
        radius: 28,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: faith.onHeader.withValues(alpha: 0.2), width: 2),
          ),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: faith.gold,
            foregroundImage: photo == null ? null : NetworkImage(photo),
            child: Text(
              user?.initial ?? 'S',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: faith.onAction),
            ),
          ),
        ),
      ),
    );
  }
}

/// Translucent verse card inside the navy header.
class EncouragementCard extends StatelessWidget {
  const EncouragementCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: faith.onHeader.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: faith.onHeader.withValues(alpha: 0.2)),
      ),
      child: child,
    );
  }
}

/// Verse text in italics followed by its reference in gold.
class PassageText extends StatelessWidget {
  const PassageText({super.key, required this.passage, this.onHeader = false});

  final Passage passage;
  final bool onHeader;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '"${passage.text}"',
          style: (onHeader ? text.bodyMedium : text.bodyLarge)?.copyWith(
            fontStyle: onHeader ? FontStyle.italic : null,
            color: onHeader ? faith.onHeaderMuted : null,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(passage.label, style: text.labelMedium?.copyWith(color: faith.gold)),
      ],
    );
  }
}

/// "Renungan Hari Ini" summary card.
class DevotionalSummaryCard extends StatelessWidget {
  const DevotionalSummaryCard({super.key, required this.devotional, required this.onTap});

  final Devotional devotional;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    final text = Theme.of(context).textTheme;
    return FaithCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, size: 16, color: faith.sunset),
                    const SizedBox(width: AppSpacing.xs),
                    Flexible(
                      child: Text(
                        'Renungan Hari Ini',
                        style: text.labelMedium?.copyWith(color: faith.sunset),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(devotional.title, style: text.titleMedium),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  devotional.body,
                  style: text.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Icon(Icons.chevron_right, color: faith.mutedForeground),
        ],
      ),
    );
  }
}

/// Square shortcut tile (Tanya fAIth, Jurnal Doa).
class QuickActionTile extends StatelessWidget {
  const QuickActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.emphasized = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  /// Navy gradient background (primary shortcut) instead of the card surface.
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    final text = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(AppRadius.lg);
    final iconColor = emphasized ? faith.gold : faith.sunset;
    final titleColor = emphasized ? faith.onHeader : null;
    final subtitleColor = emphasized ? faith.onHeaderMuted : null;

    final content = Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(title, style: text.titleSmall?.copyWith(color: titleColor)),
          const SizedBox(height: AppSpacing.xxs),
          Text(subtitle, style: text.bodySmall?.copyWith(color: subtitleColor)),
        ],
      ),
    );

    return Semantics(
      button: true,
      child: emphasized
          ? Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(gradient: faith.headerGradient, borderRadius: radius),
                child: InkWell(onTap: onTap, borderRadius: radius, child: content),
              ),
            )
          : Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(onTap: onTap, child: content),
            ),
    );
  }
}

/// "Gereja Terdekat" teaser with the nearest church.
class ChurchTeaserCard extends StatelessWidget {
  const ChurchTeaserCard({super.key, required this.body, required this.onTap});

  /// Church row, or a loading/error/empty view.
  final Widget body;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    return FaithCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.place_outlined, color: faith.gold),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text('Gereja Terdekat', style: Theme.of(context).textTheme.titleMedium),
              ),
              Icon(Icons.chevron_right, color: faith.mutedForeground),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          body,
        ],
      ),
    );
  }
}

class ChurchRow extends StatelessWidget {
  const ChurchRow({super.key, required this.church});

  final Church church;

  @override
  Widget build(BuildContext context) {
    final faith = context.faith;
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: faith.highlightGradient,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(Icons.church_outlined, color: faith.gold),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                church.name,
                style: text.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text('${church.distanceLabel} • ${church.denomination}', style: text.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
