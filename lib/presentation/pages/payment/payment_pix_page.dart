import 'package:flutter/material.dart';

class PaymentPixPage extends StatelessWidget {
  final String pixCode;
  const PaymentPixPage(
      {super.key,
      this.pixCode =
          '00020126360014BR.GOV.BCB.PIX0114+5511999999995204000053039865405100.005802BR5920NOME DO RECEBEDOR6009Sao Paulo62070503***6304B14F'});

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
            const Text('Escaneie o QR Code abaixo para pagar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Container(
              width: 240.0,
              height: 240.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'QR Code\n(Instale qr_flutter)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SelectableText(pixCode, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
