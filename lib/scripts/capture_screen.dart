import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenCapture extends StatefulWidget {
  const ScreenCapture({super.key});

  @override
  State<ScreenCapture> createState() => _ScreenCaptureState();
}

class _ScreenCaptureState extends State<ScreenCapture> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _captureScreen());
  }

  Future<void> _captureScreen() async {
    try {
      final RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 1.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();
        final File file = File('assets/images/app_icon.png');
        await file.writeAsBytes(pngBytes);
        debugPrint('Screenshot saved to ${file.path}');
      }
    } catch (e) {
      debugPrint('Error capturing screen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RepaintBoundary(
          key: _globalKey,
          child: Container(
            width: 1024,
            height: 1024,
            color: const Color(0xFF2196F3),
            child: Center(
              child: Container(
                width: 512,
                height: 512,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const ScreenCapture());
} 