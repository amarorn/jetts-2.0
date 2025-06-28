import 'package:flutter/material.dart';
import '../../../design_system/components/inputs/app_text_field.dart';
import '../../../design_system/components/buttons/app_button.dart';

/// Página de pagamento com cartão de crédito/débito.

class PaymentCardPage extends StatefulWidget {
  const PaymentCardPage({super.key});

  @override
  State<PaymentCardPage> createState() => _PaymentCardPageState();
}

class _PaymentCardPageState extends State<PaymentCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

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
            const Text('Preencha os dados do cartão',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            AppTextField(
              controller: _cardNumberController,
              label: 'Número do Cartão',
              hint: '0000 0000 0000 0000',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _expiryController,
                    label: 'Validade',
                    hint: 'MM/AA',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    controller: _cvvController,
                    label: 'CVV',
                    hint: '123',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _nameController,
              label: 'Nome no Cartão',
              hint: 'Como aparece no cartão',
            ),
            const Spacer(),
            AppButton(
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
