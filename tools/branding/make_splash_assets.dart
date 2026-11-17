// Derives the splash images from the launcher icon art in assets/.
//
// Run from the repo root:
//   dart run tools/branding/make_splash_assets.dart
// then: dart run flutter_native_splash:create
import 'dart:io';

import 'package:image/image.dart' as img;

/// Splash logo width in px (@4x of SplashPage.logoWidth = 160dp).
const int logoWidth = 640;

/// Android 12 splash icon canvas (content must fit a 768px circle).
const int a12Canvas = 1152;
const int a12LogoWidth = 520;

void main() {
  final fg = img.decodePng(File('assets/icon_foreground.png').readAsBytesSync())!;

  // Bounding box of visible pixels.
  var minX = fg.width, minY = fg.height, maxX = -1, maxY = -1;
  for (final p in fg) {
    if (p.a > 8) {
      if (p.x < minX) minX = p.x;
      if (p.x > maxX) maxX = p.x;
      if (p.y < minY) minY = p.y;
      if (p.y > maxY) maxY = p.y;
    }
  }
  final w = maxX - minX + 1, h = maxY - minY + 1;
  stdout.writeln('foreground content: ${w}x$h at ($minX,$minY)');
  final logo = img.copyCrop(fg, x: minX, y: minY, width: w, height: h);

  Directory('assets/splash').createSync(recursive: true);
  final splash = img.copyResize(logo, width: logoWidth, interpolation: img.Interpolation.cubic);
  File('assets/splash/splash_logo.png').writeAsBytesSync(img.encodePng(splash));
  stdout.writeln('splash_logo.png ${splash.width}x${splash.height}');

  final small = img.copyResize(logo, width: a12LogoWidth, interpolation: img.Interpolation.cubic);
  final canvas = img.Image(width: a12Canvas, height: a12Canvas, numChannels: 4);
  img.compositeImage(
    canvas,
    small,
    dstX: (a12Canvas - small.width) ~/ 2,
    dstY: (a12Canvas - small.height) ~/ 2,
  );
  File('assets/splash/splash_android12.png').writeAsBytesSync(img.encodePng(canvas));

  // Background samples, for AppColors / native splash colors.
  final bg = img.decodePng(File('assets/icon_background.png').readAsBytesSync())!;
  String hex(int x, int y) {
    final p = bg.getPixel(x, y);
    return [p.r, p.g, p.b].map((c) => c.toInt().toRadixString(16).padLeft(2, '0')).join();
  }

  final s = bg.width - 1;
  stdout.writeln('bg top=${hex(s ~/ 2, 0)} center=${hex(s ~/ 2, s * 42 ~/ 100)} '
      'mid=${hex(s ~/ 2, s ~/ 2)} bottom=${hex(s ~/ 2, s)} corner=${hex(0, 0)} '
      'midEdge=${hex(0, s ~/ 2)}');
  final mono = img.decodePng(File('assets/icon_monochrome.png').readAsBytesSync())!;
  stdout.writeln('mono channels=${mono.numChannels} corner alpha=${mono.getPixel(0, 0).a}');
}
