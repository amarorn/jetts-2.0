import 'package:flutter/material.dart';
import '../../design_system/design_system.dart';

class PaymentCardPage extends StatelessWidget {
  const PaymentCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento com Cartão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Preencha os dados do cartão', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            JettsTextField(
              label: 'Número do Cartão',
              hint: '0000 0000 0000 0000',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: JettsTextField(
                    label: 'Validade',
                    hint: 'MM/AA',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: JettsTextField(
                    label: 'CVV',
                    hint: '123',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            JettsTextField(
              label: 'Nome no Cartão',
              hint: 'Como aparece no cartão',
            ),
            const Spacer(),
            JettsButton(
              onPressed: () {
                // Implementar lógica de pagamento
              },
              text: 'Pagar',
            ),
          ],
        ),
      ),
    );
  }
} 