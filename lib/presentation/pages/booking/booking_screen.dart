import 'package:flutter/material.dart';
import '../../../domain/models/boat_model.dart';
import '../../../domain/models/payment_model.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../design_system/components/cards/boat_card.dart';
import 'package:intl/intl.dart';
import '../../pages/payment/payment_routes.dart';

class BookingScreen extends StatefulWidget {
  final BoatModel boat;
  const BookingScreen({super.key, required this.boat});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTimeRange? _selectedRange;
  int _people = 1;
  final TextEditingController _obsController = TextEditingController();
  final TextEditingController _couponController = TextEditingController();
  bool _isLoading = false;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.creditCard;
  List<PaymentSplit> _paymentSplits = [];
  List<AddOn> _addOns = [];
  List<Insurance> _insurances = [];
  Coupon? _appliedCoupon;

  @override
  void initState() {
    super.initState();
    _initializeAddOns();
    _initializeInsurances();
  }

  void _initializeAddOns() {
    _addOns = [
      AddOn(
        id: '1',
        name: 'Capitão',
        description: 'Capitão profissional para navegação',
        price: 500.0,
        icon: Icons.person,
      ),
      AddOn(
        id: '2',
        name: 'Combustível',
        description: 'Tanque cheio de combustível',
        price: 300.0,
        icon: Icons.local_gas_station,
      ),
      AddOn(
        id: '3',
        name: 'Equipamentos',
        description: 'Equipamentos de mergulho e pesca',
        price: 200.0,
        icon: Icons.sports_handball,
      ),
    ];
  }

  void _initializeInsurances() {
    _insurances = [
      Insurance(
        id: '1',
        name: 'Seguro Básico',
        description: 'Cobertura para danos básicos',
        price: 100.0,
        coverage: 5000.0,
      ),
      Insurance(
        id: '2',
        name: 'Seguro Premium',
        description: 'Cobertura completa',
        price: 200.0,
        coverage: 10000.0,
      ),
    ];
  }

  @override
  void dispose() {
    _obsController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  void _selectDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      selectableDayPredicate: (date, start, end) {
        return !widget.boat.unavailableDates.any((d) => d.year == date.year && d.month == date.month && d.day == date.day);
      },
    );
    if (picked != null) setState(() => _selectedRange = picked);
  }

  void _addPaymentSplit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Participante'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nome'),
              onChanged: (value) => _tempName = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) => _tempEmail = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _tempAmount = double.tryParse(value) ?? 0,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (_tempName.isNotEmpty && _tempEmail.isNotEmpty && _tempAmount > 0) {
                setState(() {
                  _paymentSplits.add(PaymentSplit(
                    name: _tempName,
                    email: _tempEmail,
                    amount: _tempAmount,
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  String _tempName = '';
  String _tempEmail = '';
  double _tempAmount = 0;

  void _applyCoupon() {
    // Simulação de validação de cupom
    if (_couponController.text.isNotEmpty) {
      setState(() {
        _appliedCoupon = Coupon(
          code: _couponController.text,
          description: 'Desconto de 10%',
          discount: 10.0,
          expiryDate: DateTime.now().add(const Duration(days: 30)),
          isPercentage: true,
        );
      });
    }
  }

  double _calculateSubtotal() {
    if (_selectedRange == null) return 0.0;
    double total = 0.0;
    DateTime day = _selectedRange!.start;
    while (!day.isAfter(_selectedRange!.end)) {
      total += widget.boat.dynamicPrices[DateTime(day.year, day.month, day.day)] ?? widget.boat.price;
      day = day.add(const Duration(days: 1));
    }
    return total * _people;
  }

  double _calculateAddOns() {
    return _addOns.where((addon) => addon.isSelected).fold(0.0, (sum, addon) => sum + addon.price);
  }

  double _calculateInsurance() {
    return _insurances.where((insurance) => insurance.isSelected).fold(0.0, (sum, insurance) => sum + insurance.price);
  }

  double _calculateDiscount() {
    if (_appliedCoupon == null) return 0.0;
    final subtotal = _calculateSubtotal();
    return _appliedCoupon!.isPercentage
        ? subtotal * (_appliedCoupon!.discount / 100)
        : _appliedCoupon!.discount;
  }

  double _calculateTotal() {
    final subtotal = _calculateSubtotal();
    final addOns = _calculateAddOns();
    final insurance = _calculateInsurance();
    final discount = _calculateDiscount();
    return subtotal + addOns + insurance - discount;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = _calculateTotal();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserva'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoatCard(
                boat: widget.boat,
                onTap: () {},
                onFavorite: () {},
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Seção de Período
              Text('Período da reserva', style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              GestureDetector(
                onTap: _selectDateRange,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, color: theme.colorScheme.primary),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        _selectedRange == null
                            ? 'Escolher período'
                            : '${DateFormat('dd/MM/yyyy').format(_selectedRange!.start)} até ${DateFormat('dd/MM/yyyy').format(_selectedRange!.end)}',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Seção de Pessoas
              Text('Quantidade de pessoas', style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  IconButton(
                    onPressed: _people > 1 ? () => setState(() => _people--) : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text('$_people', style: AppTypography.titleMedium),
                  IconButton(
                    onPressed: _people < 50 ? () => setState(() => _people++) : null,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Seção de Adicionais
              Text('Adicionais', style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              ..._addOns.map((addon) => CheckboxListTile(
                title: Text(addon.name),
                subtitle: Text('${addon.description} - R\$ ${addon.price.toStringAsFixed(2)}'),
                value: addon.isSelected,
                onChanged: (value) {
                  setState(() {
                    addon.isSelected = value ?? false;
                  });
                },
              )),
              const SizedBox(height: AppSpacing.lg),

              // Seção de Seguros
              Text('Seguros', style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              ..._insurances.map((insurance) => CheckboxListTile(
                title: Text(insurance.name),
                subtitle: Text('${insurance.description} - R\$ ${insurance.price.toStringAsFixed(2)}'),
                value: insurance.isSelected,
                onChanged: (value) {
                  setState(() {
                    insurance.isSelected = value ?? false;
                  });
                },
              )),
              const SizedBox(height: AppSpacing.lg),

              // Seção de Cupom
              Text('Cupom de desconto', style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _couponController,
                      decoration: InputDecoration(
                        hintText: 'Digite o código do cupom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    onPressed: _applyCoupon,
                    child: const Text('Aplicar'),
                  ),
                ],
              ),
              if (_appliedCoupon != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm),
                  child: Text(
                    'Cupom aplicado: ${_appliedCoupon!.code} - ${_appliedCoupon!.description}',
                    style: AppTypography.bodySmall.copyWith(color: theme.colorScheme.primary),
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),

              // Seção de Divisão de Pagamento
              Text('Divisão do pagamento', style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              ElevatedButton.icon(
                onPressed: _addPaymentSplit,
                icon: const Icon(Icons.person_add),
                label: const Text('Adicionar Participante'),
              ),
              if (_paymentSplits.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                ..._paymentSplits.map((split) => ListTile(
                  title: Text(split.name),
                  subtitle: Text(split.email),
                  trailing: Text('R\$ ${split.amount.toStringAsFixed(2)}'),
                )),
              ],
              const SizedBox(height: AppSpacing.lg),

              // Seção de Método de Pagamento
              Text('Método de pagamento', style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: PaymentMethod.values.map((method) => ChoiceChip(
                  label: Text(method.toString().split('.').last),
                  selected: _selectedPaymentMethod == method,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedPaymentMethod = method;
                      });
                    }
                  },
                )).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Seção de Observações
              Text('Observações (opcional)', style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _obsController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Ex: Pedido especial, restrição alimentar...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Resumo do Pagamento
              Text('Resumo do pagamento', style: AppTypography.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              if (_selectedRange != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (DateTime day = _selectedRange!.start;
                        !day.isAfter(_selectedRange!.end);
                        day = day.add(const Duration(days: 1)))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd/MM/yyyy').format(day), style: AppTypography.bodyMedium),
                          Text('R\$ ${(widget.boat.dynamicPrices[DateTime(day.year, day.month, day.day)] ?? widget.boat.price).toStringAsFixed(2)}', style: AppTypography.bodyMedium),
                        ],
                      ),
                  ],
                ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal', style: AppTypography.bodyMedium),
                  Text('R\$ ${_calculateSubtotal().toStringAsFixed(2)}', style: AppTypography.bodyMedium),
                ],
              ),
              if (_calculateAddOns() > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Adicionais', style: AppTypography.bodyMedium),
                    Text('R\$ ${_calculateAddOns().toStringAsFixed(2)}', style: AppTypography.bodyMedium),
                  ],
                ),
              if (_calculateInsurance() > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Seguros', style: AppTypography.bodyMedium),
                    Text('R\$ ${_calculateInsurance().toStringAsFixed(2)}', style: AppTypography.bodyMedium),
                  ],
                ),
              if (_calculateDiscount() > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Desconto', style: AppTypography.bodyMedium),
                    Text('- R\$ ${_calculateDiscount().toStringAsFixed(2)}', style: AppTypography.bodyMedium),
                  ],
                ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: AppTypography.titleLarge),
                  Text('R\$ ${total.toStringAsFixed(2)}', style: AppTypography.titleLarge),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Botão de Confirmação
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedRange == null || _isLoading
                      ? null
                      : () async {
                          if (_selectedPaymentMethod == PaymentMethod.creditCard || _selectedPaymentMethod == PaymentMethod.debitCard) {
                            Navigator.pushNamed(context, '/payment-card');
                          } else if (_selectedPaymentMethod == PaymentMethod.pix) {
                            Navigator.pushNamed(context, '/payment-pix');
                          } else {
                            Navigator.pushNamed(context, PaymentRoutes.payment);
                          }
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Confirmar Reserva'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 