import 'package:flutter/material.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/components/inputs/app_text_field.dart';

class BoatRegisterStepperScreen extends StatefulWidget {
  const BoatRegisterStepperScreen({super.key});

  @override
  State<BoatRegisterStepperScreen> createState() =>
      _BoatRegisterStepperScreenState();
}

class _BoatRegisterStepperScreenState extends State<BoatRegisterStepperScreen> {
  int _currentStep = 0;

  final List<String> _steps = [
    'Acesso',
    'Básico',
    'Técnico',
    'Localização',
    'Comodidades',
    'Imagens',
    'Preços',
    'Serviços',
    'Políticas',
    'Documentos',
    'Revisão',
  ];

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Embarcação'),
        backgroundColor: AppColors.primaryBlue900,
      ),
      backgroundColor: AppColors.primaryBlue900,
      body: SafeArea(
        child: Column(
          children: [
            _buildStepper(),
            const SizedBox(height: 16),
            Expanded(child: _buildStepContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Container(
      color: AppColors.primaryBlue900,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: (_currentStep + 1) / _steps.length,
            backgroundColor: Colors.white.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue400),
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _steps[_currentStep],
                style: AppTypography.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_currentStep + 1} de ${_steps.length}',
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildAccessStep();
      case 1:
        return _buildBasicInfoStep();
      case 2:
        return _buildTechnicalSpecsStep();
      case 3:
        return _buildLocationStep();
      case 4:
        return _buildAmenitiesStep();
      case 5:
        return _buildGalleryStep();
      case 6:
        return _buildPricingStep();
      case 7:
        return _buildServicesStep();
      case 8:
        return _buildPoliciesStep();
      case 9:
        return _buildDocumentsStep();
      case 10:
        return _buildReviewStep();
      default:
        return Center(
            child: Text('Etapa em construção',
                style: AppTypography.bodyLarge.copyWith(color: Colors.white)));
    }
  }

  // Etapa 2: Informações Básicas
  final _formKeyBasic = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _yearController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _lengthController = TextEditingController();
  final _capacityController = TextEditingController();

  String? _selectedType;
  final List<String> _boatTypes = [
    'Lancha',
    'Iate',
    'Jet Ski',
    'Veleiro',
    'Catamarã',
    'Barco de Pesca',
    'Outro'
  ];

  Widget _buildBasicInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKeyBasic,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('Informações Básicas',
                style: AppTypography.titleLarge.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            AppTextField(
              controller: _nameController,
              label: 'Nome da Embarcação',
              hint: 'Ex: Iate Premium',
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe o nome' : null,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _selectedType,
              dropdownColor: AppColors.primaryBlue900,
              decoration: InputDecoration(
                labelText: 'Tipo de Embarcação',
                labelStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: AppColors.primaryBlue900.withOpacity(0.7),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
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
            const SizedBox(height: 14),
            AppTextField(
              controller: _yearController,
              label: 'Ano de Fabricação',
              hint: 'Ex: 2022',
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty ? 'Informe o ano' : null,
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _brandController,
              label: 'Fabricante/Marca',
              hint: 'Ex: Azimut',
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe a marca' : null,
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _modelController,
              label: 'Modelo',
              hint: 'Ex: 56 Flybridge',
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe o modelo' : null,
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _lengthController,
              label: 'Comprimento (m)',
              hint: 'Ex: 18.5',
              keyboardType: TextInputType.number,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe o comprimento' : null,
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _capacityController,
              label: 'Capacidade Máxima',
              hint: 'Ex: 12',
              keyboardType: TextInputType.number,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe a capacidade' : null,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: AppButton(
                      onPressed: _prevStep,
                      text: 'Voltar',
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    onPressed: () {
                      if (_formKeyBasic.currentState!.validate()) {
                        _nextStep();
                      }
                    },
                    text: 'Próximo',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Etapa 3: Especificações Técnicas
  final _formKeyTech = GlobalKey<FormState>();
  final _engineBrandController = TextEditingController();
  final _enginePowerController = TextEditingController();
  final _engineTypeController = TextEditingController();
  final _fuelTypeController = TextEditingController();
  final _fuelCapacityController = TextEditingController();
  final _registrationController = TextEditingController();
  String? _uploadedDoc;

  Widget _buildTechnicalSpecsStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKeyTech,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('Especificações Técnicas',
                style: AppTypography.titleLarge.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            AppTextField(
              controller: _engineBrandController,
              label: 'Marca do Motor',
              hint: 'Ex: Volvo',
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe a marca do motor' : null,
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _enginePowerController,
              label: 'Potência do Motor (HP)',
              hint: 'Ex: 350',
              keyboardType: TextInputType.number,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe a potência' : null,
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _engineTypeController,
              label: 'Tipo de Motor',
              hint: 'Ex: Popa, Centro, Elétrico',
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe o tipo de motor' : null,
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _fuelTypeController,
              label: 'Tipo de Combustível',
              hint: 'Ex: Gasolina, Diesel',
              validator: (v) => v == null || v.isEmpty
                  ? 'Informe o tipo de combustível'
                  : null,
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _fuelCapacityController,
              label: 'Capacidade do Tanque (L)',
              hint: 'Ex: 400',
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty
                  ? 'Informe a capacidade do tanque'
                  : null,
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _registrationController,
              label: 'Número de Registro/Inscrição',
              hint: 'Ex: 123456789',
              validator: (v) => v == null || v.isEmpty
                  ? 'Informe o número de registro'
                  : null,
            ),
            const SizedBox(height: 18),
            Text('Documentação da Embarcação',
                style: AppTypography.bodyLarge.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _uploadedDoc = 'documento_mock.pdf';
                });
              },
              icon: const Icon(Icons.upload_file),
              label: Text(_uploadedDoc == null
                  ? 'Fazer upload (mock)'
                  : 'Documento enviado: $_uploadedDoc'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue400,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: _prevStep,
                    text: 'Voltar',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    onPressed: () {
                      if (_formKeyTech.currentState!.validate()) {
                        _nextStep();
                      }
                    },
                    text: 'Próximo',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Controladores para as novas etapas
  final TextEditingController _marinaNameController = TextEditingController();
  final TextEditingController _marinaAddressController =
      TextEditingController();
  final TextEditingController _marinaPhoneController = TextEditingController();
  final TextEditingController _marinaCityController = TextEditingController();
  final TextEditingController _marinaGpsController = TextEditingController();
  final TextEditingController _marinaReferenceController =
      TextEditingController();

  final TextEditingController _priceDayController = TextEditingController();
  final TextEditingController _priceHourController = TextEditingController();
  final TextEditingController _discountWeekController = TextEditingController();
  final TextEditingController _discountMonthController =
      TextEditingController();
  final TextEditingController _cleaningFeeController = TextEditingController();
  final TextEditingController _fuelController = TextEditingController();

  final TextEditingController _captainController = TextEditingController();
  final TextEditingController _crewController = TextEditingController();
  final TextEditingController _cateringController = TextEditingController();
  final TextEditingController _specialEquipController = TextEditingController();
  final TextEditingController _decorationController = TextEditingController();

  final TextEditingController _cancelPolicyController = TextEditingController();
  final TextEditingController _rulesController = TextEditingController();
  final TextEditingController _safetyTermsController = TextEditingController();

  // Etapa 4: Localização e Marina
  Widget _buildLocationStep() {
    return _stepScaffold(
      title: 'Localização e Marina',
      children: [
        AppTextField(
            label: 'Nome da Marina', controller: _marinaNameController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Endereço Completo', controller: _marinaAddressController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Telefone da Marina', controller: _marinaPhoneController),
        const SizedBox(height: 14),
        AppTextField(label: 'Cidade/Estado', controller: _marinaCityController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Coordenadas GPS (opcional)',
            controller: _marinaGpsController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Pontos de Referência',
            controller: _marinaReferenceController),
      ],
    );
  }

  // Etapa 5: Amenidades e Comodidades
  Widget _buildAmenitiesStep() {
    return _stepScaffold(
      title: 'Amenidades e Comodidades',
      children: [
        Text(
            'Selecione os equipamentos de segurança e comodidades disponíveis:',
            style: TextStyle(color: Colors.white)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 4,
          children: [
            FilterChip(
                label: Text('Coletes Salva-vidas'),
                selected: true,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Extintor de Incêndio'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Kit de Primeiros Socorros'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Sinalizadores'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Piscina/Deck'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(label: Text('Bar'), selected: false, onSelected: (_) {}),
            FilterChip(
                label: Text('Jacuzzi/Spa'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Sistema de Som'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Ar Condicionado'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Cozinha Equipada'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Cabines/Quartos'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Banheiros'), selected: false, onSelected: (_) {}),
            FilterChip(
                label: Text('Equipamentos de Pesca'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Equipamentos de Mergulho'),
                selected: false,
                onSelected: (_) {}),
            FilterChip(
                label: Text('Equipamentos Aquáticos'),
                selected: false,
                onSelected: (_) {}),
          ],
        ),
      ],
    );
  }

  // Etapa 6: Galeria de Imagens
  Widget _buildGalleryStep() {
    return _stepScaffold(
      title: 'Galeria de Imagens',
      children: [
        Text('Adicione fotos da embarcação (mock):',
            style: TextStyle(color: Colors.white)),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_a_photo),
          label: const Text('Adicionar Foto'),
        ),
        const SizedBox(height: 10),
        Text('Mínimo: 3 fotos externas, máximo: 20 imagens.',
            style: TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }

  // Etapa 7: Preços e Disponibilidade
  Widget _buildPricingStep() {
    return _stepScaffold(
      title: 'Preços e Disponibilidade',
      children: [
        AppTextField(
            label: 'Preço Base Diário (R\$)', controller: _priceDayController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Preço por Hora (opcional)',
            controller: _priceHourController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Desconto Semanal (%)', controller: _discountWeekController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Desconto Mensal (%)', controller: _discountMonthController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Taxa de Limpeza (R\$)', controller: _cleaningFeeController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Combustível (incluso ou à parte)',
            controller: _fuelController),
      ],
    );
  }

  // Etapa 8: Serviços Adicionais
  Widget _buildServicesStep() {
    return _stepScaffold(
      title: 'Serviços Adicionais',
      children: [
        AppTextField(
            label: 'Capitão (obrigatório/opcional)',
            controller: _captainController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Tripulação Adicional', controller: _crewController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Catering/Alimentação (R\$ por pessoa)',
            controller: _cateringController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Equipamentos Especiais (R\$ por item)',
            controller: _specialEquipController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Decoração para Eventos (R\$ por pacote)',
            controller: _decorationController),
      ],
    );
  }

  // Etapa 9: Políticas e Regras
  Widget _buildPoliciesStep() {
    return _stepScaffold(
      title: 'Políticas e Regras',
      children: [
        AppTextField(
            label: 'Política de Cancelamento',
            controller: _cancelPolicyController),
        const SizedBox(height: 14),
        AppTextField(label: 'Regras de Uso', controller: _rulesController),
        const SizedBox(height: 14),
        AppTextField(
            label: 'Termos de Segurança', controller: _safetyTermsController),
      ],
    );
  }

  // Etapa 10: Documentação
  Widget _buildDocumentsStep() {
    return _stepScaffold(
      title: 'Documentação',
      children: [
        Text('Faça upload dos documentos obrigatórios (mock):',
            style: TextStyle(color: Colors.white)),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.upload_file),
          label: const Text('Enviar Documento'),
        ),
        const SizedBox(height: 10),
        Text('Ex: Certificado de Registro, Seguro, Licença, etc.',
            style: TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }

  // Etapa 11: Revisão e Publicação
  Widget _buildReviewStep() {
    return _stepScaffold(
      title: 'Revisão e Publicação',
      children: [
        Text('Revise todos os dados antes de publicar sua embarcação.',
            style: TextStyle(color: Colors.white)),
        const SizedBox(height: 24),
        AppButton(
          onPressed: () {},
          text: 'Publicar',
        ),
      ],
    );
  }

  // Widget auxiliar para steps
  Widget _stepScaffold(
      {required String title, required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(title,
              style: AppTypography.titleLarge
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          ...children,
          const SizedBox(height: 24),
          Row(
            children: [
              if (_currentStep > 0)
                Expanded(
                  child: AppButton(
                    onPressed: _prevStep,
                    text: 'Voltar',
                  ),
                ),
              if (_currentStep > 0) const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  onPressed: _nextStep,
                  text: _currentStep == 10 ? 'Finalizar' : 'Próximo',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccessStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Verificação de Acesso',
              style: AppTypography.titleLarge
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text('Simulação de verificação de login e perfil completo. (Mock)',
              style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 32),
          AppButton(
            onPressed: _nextStep,
            text: 'Continuar',
          ),
        ],
      ),
    );
  }
}
