import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Future<void> main() async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final size = const Size(1024, 1024);

  // Desenhar fundo
  final paint = Paint()
    ..color = const Color(0xFF2196F3)
    ..style = PaintingStyle.fill;
  canvas.drawRect(
    Rect.fromLTWH(0, 0, size.width, size.height),
    paint,
  );

  // Desenhar círculo
  final circlePaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  canvas.drawCircle(
    Offset(size.width / 2, size.height / 2),
    size.width / 4,
    circlePaint,
  );

  // Finalizar e salvar
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final buffer = byteData!.buffer.asUint8List();

  // Salvar arquivo
  final file = File('assets/images/splash.png');
  await file.writeAsBytes(buffer);
} 