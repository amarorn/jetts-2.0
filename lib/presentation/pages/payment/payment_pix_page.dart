import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentPixPage extends StatelessWidget {
  final String pixCode;
  const PaymentPixPage({super.key, this.pixCode = '00020126360014BR.GOV.BCB.PIX0114+5511999999995204000053039865405100.005802BR5920NOME DO RECEBEDOR6009Sao Paulo62070503***6304B14F'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento via Pix'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Escaneie o QR Code abaixo para pagar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            QrImage(
              data: pixCode,
              version: QrVersions.auto,
              size: 240.0,
            ),
            const SizedBox(height: 32),
            SelectableText(pixCode, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
} 