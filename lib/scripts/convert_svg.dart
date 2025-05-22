import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  // Converter app_icon.svg para PNG
  final appIconSvg = await rootBundle.loadString('assets/images/app_icon.svg');
  final appIconPicture = await svg.fromSvgString(appIconSvg, 'app_icon');
  final appIconImage = await appIconPicture.toImage(1024, 1024);
  final appIconBytes = await appIconImage.toByteData(format: ImageByteFormat.png);
  final appIconFile = File('assets/images/app_icon.png');
  await appIconFile.writeAsBytes(appIconBytes!.buffer.asUint8List());

  // Converter splash.svg para PNG
  final splashSvg = await rootBundle.loadString('assets/images/splash.svg');
  final splashPicture = await svg.fromSvgString(splashSvg, 'splash');
  final splashImage = await splashPicture.toImage(1024, 1024);
  final splashBytes = await splashImage.toByteData(format: ImageByteFormat.png);
  final splashFile = File('assets/images/splash.png');
  await splashFile.writeAsBytes(splashBytes!.buffer.asUint8List());
} 