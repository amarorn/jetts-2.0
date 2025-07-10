import 'package:flutter/material.dart';
import '../../../design_system/components/inputs/app_text_field.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_typography.dart';

class BoatRegisterDetailsScreen extends StatefulWidget {
  const BoatRegisterDetailsScreen({super.key});

  @override
  State<BoatRegisterDetailsScreen> createState() =>
      _BoatRegisterDetailsScreenState();
}

class _BoatRegisterDetailsScreenState extends State<BoatRegisterDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  final Map<String, bool> _comodidades = {
    'Churrasqueira': false,
    'Som': false,
    'Piscina': false,
    'Bar': false,
    'Banheiro': false,
    'Cozinha': false,
    'Wi-Fi': false,
    'Deck': false,
    'Jacuzzi': false,
  };

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _goToNext() {
    if (_formKey.currentState!.validate()) {
      // Navegar para próxima etapa (fotos)
      // Exemplo: Navigator.push(context, MaterialPageRoute(builder: (_) => BoatRegisterPhotosScreen(...)));
    }
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Embarcação'),
        backgroundColor: AppColors.primaryBlue900,
      ),
      backgroundColor: AppColors.primaryBlue900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Detalhes e Comodidades',
                  style: AppTypography.titleLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _descController,
                  label: 'Descrição',
                  hint: 'Ex: Iate de luxo com piscina, bar e churrasqueira',
                  maxLines: 3,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe a descrição' : null,
                ),
                const SizedBox(height: 18),
                Text('Comodidades',
                    style: AppTypography.bodyLarge.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: _comodidades.keys
                      .map((c) => FilterChip(
                            label: Text(c,
                                style: const TextStyle(color: Colors.white)),
                            selected: _comodidades[c]!,
                            backgroundColor:
                                AppColors.primaryBlue900.withOpacity(0.4),
                            selectedColor: AppColors.primaryBlue400,
                            checkmarkColor: Colors.white,
                            onSelected: (v) =>
                                setState(() => _comodidades[c] = v),
                          ))
                      .toList(),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onPressed: _goBack,
                        text: 'Voltar',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        onPressed: _goToNext,
                        text: 'Próximo',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
