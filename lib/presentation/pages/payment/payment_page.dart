import 'package:flutter/material.dart';
import 'package:jetts_2_0/design_system/design_system.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detalhes do Pagamento',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              // Formulário de pagamento será adicionado aqui
              Expanded(
                child: ListView(
                  children: [
                    _buildPaymentForm(),
                  ],
                ),
              ),
              JettsButton(
                onPressed: () {
                  // Implementar lógica de pagamento
                },
                text: 'Confirmar Pagamento',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informações do Cartão',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
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
                label: 'Data de Validade',
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
      ],
    );
  }
} 