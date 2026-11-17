import 'dart:async';
import 'dart:math' as math;

import 'package:faith_mobile/core/routes/app_routes.dart';
import 'package:faith_mobile/core/theme/app_colors.dart';
import 'package:faith_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Animated splash that continues the native splash (same background, logo centered at
/// [SplashPage.logoWidth]) and then routes to the shell or login.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.onFinished});

  /// Called once the intro is done. Defaults to routing by auth state.
  final VoidCallback? onFinished;

  /// Logo width in dp; matches `assets/splash/splash_logo.png` (640px @4x) in the native splash.
  static const double logoWidth = 160;
  static const Duration introDuration = Duration(milliseconds: 1600);
  static const Duration holdDuration = Duration(milliseconds: 700);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: SplashPage.introDuration,
  );
  late final AnimationController _ambient = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  );
  Timer? _hold;

  Animation<double> _interval(double begin, double end, [Curve curve = Curves.easeOutCubic]) =>
      CurvedAnimation(parent: _intro, curve: Interval(begin, end, curve: curve));

  late final Animation<double> _lift = _interval(0.0, 0.5);
  late final Animation<double> _glow = _interval(0.0, 0.55, Curves.easeOut);
  late final Animation<double> _title = _interval(0.35, 0.75);
  late final Animation<double> _loader = _interval(0.75, 1.0, Curves.easeOut);

  @override
  void initState() {
    super.initState();
    _intro.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _hold ??= Timer(SplashPage.holdDuration, _finish);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_intro.isAnimating || _intro.isCompleted) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _intro.value = 1; // completes the intro; the status listener starts the hold.
    } else {
      _intro.forward();
      _ambient.repeat();
    }
  }

  void _finish() {
    if (!mounted) return;
    final onFinished = widget.onFinished;
    if (onFinished != null) {
      onFinished();
      return;
    }
    final auth = Get.find<AuthController>();
    unawaited(Get.offNamed(auth.isAuthenticated ? AppRoutes.shell : AppRoutes.login));
  }

  @override
  void dispose() {
    _hold?.cancel();
    _intro.dispose();
    _ambient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: AppColors.brandDeep,
        body: AnimatedBuilder(
          animation: Listenable.merge([_intro, _ambient]),
          builder: (context, _) => Stack(
            fit: StackFit.expand,
            children: [
              // Same image and stretch as the native splash background.
              const Image(
                image: AssetImage('assets/icon_background.png'),
                fit: BoxFit.fill,
                excludeFromSemantics: true,
              ),
              _buildRays(),
              _buildCenter(textTheme),
              _buildLoader(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRays() {
    return Center(
      child: Opacity(
        opacity: _glow.value,
        child: Transform.translate(
          offset: Offset(0, -_liftOffset),
          child: Transform.rotate(
            angle: _ambient.value * 2 * math.pi,
            child: const SizedBox.square(
              dimension: 520,
              child: CustomPaint(painter: _RaysPainter()),
            ),
          ),
        ),
      ),
    );
  }

  /// The logo starts exactly where the native splash left it, then rises.
  double get _liftOffset => 64 * _lift.value;

  Widget _buildCenter(TextTheme textTheme) {
    final title = (textTheme.displayLarge ?? const TextStyle()).copyWith(
      color: AppColors.brandGold,
      fontSize: 44,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w600,
    );

    final screenWidth = MediaQuery.sizeOf(context).width;
    final sideInset = -(screenWidth - SplashPage.logoWidth) / 2;

    // The logo alone is centered (so it lines up with the native splash); the text hangs
    // below it and never shifts it, whatever the text scale.
    return Center(
      child: Transform.translate(
        offset: Offset(0, -_liftOffset),
        child: SizedBox(
          width: SplashPage.logoWidth,
          height: _logoHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.brandGold.withValues(alpha: 0.25 * _glow.value),
                      blurRadius: 100,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/splash/splash_logo.png',
                  width: SplashPage.logoWidth,
                  height: _logoHeight,
                  semanticLabel: 'Logo fAIth',
                ),
              ),
              Positioned(
                top: _logoHeight + 28,
                left: sideInset,
                right: sideInset,
                child: Column(
                  children: [
                    _fadeUp(
                      _title,
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'f'),
                            TextSpan(
                              text: 'AI',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                shadows: [
                                  Shadow(
                                    color: AppColors.brandCream.withValues(alpha: 0.9),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                            ),
                            const TextSpan(text: 'th'),
                          ],
                        ),
                        style: title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Logo height at [SplashPage.logoWidth] (source art is 518 x 494, see tools/branding).
  static const double _logoHeight = SplashPage.logoWidth * 494 / 518;

  Widget _fadeUp(Animation<double> a, Widget child) {
    return Opacity(
      opacity: a.value,
      child: Transform.translate(offset: Offset(0, 14 * (1 - a.value)), child: child),
    );
  }

  Widget _buildLoader() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 56,
      child: Opacity(
        opacity: _loader.value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 3; i++) _dot(i),
          ],
        ),
      ),
    );
  }

  Widget _dot(int i) {
    // One pulse per dot, staggered, cycling ~ every 1.2 s.
    final t = (_ambient.value * 10 - i * 0.18) % 1.0;
    final pulse = math.sin(t * math.pi).clamp(0.0, 1.0);
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.brandGold.withValues(alpha: 0.35 + 0.65 * pulse),
      ),
    );
  }
}

/// Soft light rays radiating from the center, fading out toward the edge.
class _RaysPainter extends CustomPainter {
  const _RaysPainter();

  static const int _rays = 14;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.brandGold.withValues(alpha: 0.18),
          AppColors.brandGold.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    const sweep = math.pi / _rays * 0.55;
    for (var i = 0; i < _rays; i++) {
      final angle = i * 2 * math.pi / _rays;
      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: radius),
          angle - sweep / 2,
          sweep,
          false,
        )
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RaysPainter oldDelegate) => false;
}
