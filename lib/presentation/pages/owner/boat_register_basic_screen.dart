import 'package:flutter/material.dart';
import '../../../design_system/components/inputs/app_text_field.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_typography.dart';

class BoatRegisterBasicScreen extends StatefulWidget {
  const BoatRegisterBasicScreen({super.key});

  @override
  State<BoatRegisterBasicScreen> createState() =>
      _BoatRegisterBasicScreenState();
}

class _BoatRegisterBasicScreenState extends State<BoatRegisterBasicScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _capacityController = TextEditingController();
  String? _selectedType;

  final List<String> _boatTypes = [
    'Iate',
    'Lancha',
    'Veleiro',
    'Catamarã',
    'Jet Ski',
    'Barco de Pesca',
    'Outro',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  void _goToNext() {
    if (_formKey.currentState!.validate() && _selectedType != null) {
      // Navegar para próxima etapa (detalhes)
      // Exemplo: Navigator.push(context, MaterialPageRoute(builder: (_) => BoatRegisterDetailsScreen(...)));
    } else if (_selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione o tipo de embarcação.')),
      );
    }
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
                  'Dados Básicos',
                  style: AppTypography.titleLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _nameController,
                  label: 'Nome da Embarcação',
                  hint: 'Ex: Iate Premium',
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe o nome' : null,
                ),
                const SizedBox(height: 18),
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  dropdownColor: AppColors.primaryBlue900,
                  decoration: InputDecoration(
                    labelText: 'Tipo de Embarcação',
                    labelStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: AppColors.primaryBlue900.withOpacity(0.7),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  style: const TextStyle(color: Colors.white),
                  items: _boatTypes
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type,
                                style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedType = v),
                  validator: (v) => v == null ? 'Selecione o tipo' : null,
                ),
                const SizedBox(height: 18),
                AppTextField(
                  controller: _capacityController,
                  label: 'Capacidade',
                  hint: 'Ex: 8',
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe a capacidade' : null,
                ),
                const Spacer(),
                AppButton(
                  onPressed: _goToNext,
                  text: 'Próximo',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
