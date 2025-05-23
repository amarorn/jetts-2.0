import 'package:flutter/material.dart';
import '../../../domain/models/boat_model.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../design_system/components/cards/boat_card.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  RangeValues _priceRange = const RangeValues(500, 5000);
  int _capacity = 1;
  double _minRating = 0;
  List<String> _selectedCategories = [];
  List<String> _selectedAmenities = [];
  String _selectedOrder = 'Relevância';

  List<BoatModel> _results = [];
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _voiceText = '';

  // Estado para clima
  Map<String, dynamic>? _weatherData;
  final List<String> _cities = [
    'Rio de Janeiro',
    'São Paulo',
    'Florianópolis',
    'Salvador',
    'Angra dos Reis',
    'Búzios',
    'Recife',
    'Ilhabela',
    'Vitória',
    'Fortaleza',
  ];
  String _selectedCity = 'Rio de Janeiro';
  final String _weatherApiKey = '4c2f49c2-371d-11f0-b9ca-0242ac130003-4c2f4a26-371d-11f0-b9ca-0242ac130003';

  Future<void> _fetchWeather(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_weatherApiKey&units=metric&lang=pt_br';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        _weatherData = json.decode(response.body);
      });
    } else {
      setState(() {
        _weatherData = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _results = _mockResults();
    _speech = stt.SpeechToText();
    _initLocationAndWeather();
  }

  Future<void> _initLocationAndWeather() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _fetchWeather(_selectedCity);
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _fetchWeather(_selectedCity);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        _fetchWeather(_selectedCity);
        return;
      }
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: 'pt_BR');
      if (placemarks.isNotEmpty) {
        String? city = placemarks.first.locality;
        if (city != null && city.isNotEmpty && _cities.contains(city)) {
          setState(() {
            _selectedCity = city;
          });
          await _fetchWeather(city);
          return;
        }
      }
      _fetchWeather(_selectedCity);
    } catch (e) {
      _fetchWeather(_selectedCity);
    }
  }

  void _openFilters() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (context) => _FiltersModal(
        priceRange: _priceRange,
        capacity: _capacity,
        minRating: _minRating,
        selectedCategories: _selectedCategories,
        selectedAmenities: _selectedAmenities,
        selectedOrder: _selectedOrder,
        onApply: (price, cap, rating, cats, amens, order) {
          setState(() {
            _priceRange = price;
            _capacity = cap;
            _minRating = rating;
            _selectedCategories = cats;
            _selectedAmenities = amens;
            _selectedOrder = order;
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _voiceText = val.recognizedWords;
              _searchController.text = _voiceText;
              _results = _mockResults().where((b) => b.name.toLowerCase().contains(_voiceText.toLowerCase())).toList();
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Barcos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded),
            onPressed: _openFilters,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            // Cards de Localização e Clima
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.blue),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButton<String>(
                              value: _selectedCity,
                              isExpanded: true,
                              underline: SizedBox(),
                              items: _cities.map((city) => DropdownMenuItem(
                                value: city,
                                child: Text(city, overflow: TextOverflow.ellipsis),
                              )).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedCity = value;
                                  });
                                  _fetchWeather(value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          if (_weatherData != null)
                            Row(
                              children: [
                                Image.network(
                                  'https://openweathermap.org/img/wn/${_weatherData!['weather'][0]['icon']}@2x.png',
                                  width: 32,
                                  height: 32,
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_weatherData!['main']['temp'].round()}°C',
                                      style: AppTypography.titleMedium,
                                    ),
                                    Text(
                                      _weatherData!['weather'][0]['description'].toString().replaceFirstMapped(RegExp(r'^.'), (m) => m.group(0)!.toUpperCase()),
                                      style: AppTypography.bodySmall?.copyWith(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          else
                            const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            // Campo de busca
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar barcos, destinos...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  onPressed: _listen,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
              onChanged: (value) {
                setState(() {
                  _results = _mockResults().where((b) => b.name.toLowerCase().contains(value.toLowerCase())).toList();
                });
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            // Resultados
            Expanded(
              child: _results.isEmpty
                  ? Center(child: Text('Nenhum resultado encontrado', style: AppTypography.bodyLarge))
                  : ListView.separated(
                      itemCount: _results.length,
                      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
                      itemBuilder: (context, index) {
                        final boat = _results[index];
                        return BoatCard(
                          boat: boat,
                          onTap: () => Navigator.pushNamed(context, '/boat-details', arguments: boat),
                          onFavorite: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openFilters,
        icon: const Icon(Icons.tune_rounded),
        label: const Text('Filtros'),
      ),
    );
  }

  List<BoatModel> _mockResults() {
    return [
      BoatModel(
        id: '1',
        name: 'Barco de Luxo',
        location: 'Rio de Janeiro, RJ',
        price: 1500.0,
        rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
        features: ['Luxo', 'Piscina', 'Jacuzzi'],
      ),
      BoatModel(
        id: '2',
        name: 'Iate Moderno',
        location: 'São Paulo, SP',
        price: 2000.0,
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=800&q=80',
        features: ['Moderno', 'Bar', 'Churrasqueira'],
      ),
      BoatModel(
        id: '3',
        name: 'Lancha Rápida',
        location: 'Florianópolis, SC',
        price: 800.0,
        rating: 4.5,
        imageUrl: 'https://images.unsplash.com/photo-1502082553048-f009c37129b9?auto=format&fit=crop&w=800&q=80',
        features: ['Rápido', 'Econômico', 'Prático'],
      ),
      BoatModel(
        id: '4',
        name: 'Catamarã Família',
        location: 'Salvador, BA',
        price: 1200.0,
        rating: 4.7,
        imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80',
        features: ['Família', 'Espaçoso', 'Seguro'],
      ),
      BoatModel(
        id: '5',
        name: 'Barco Romântico',
        location: 'Angra dos Reis, RJ',
        price: 1800.0,
        rating: 4.6,
        imageUrl: 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=80',
        features: ['Romântico', 'Luxo', 'Vista'],
      ),
      BoatModel(
        id: '6',
        name: 'Iate Esportivo',
        location: 'Búzios, RJ',
        price: 2500.0,
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=800&q=80',
        features: ['Esporte', 'Potente', 'Bar'],
      ),
      BoatModel(
        id: '7',
        name: 'Barco Econômico',
        location: 'Recife, PE',
        price: 600.0,
        rating: 4.2,
        imageUrl: 'https://images.unsplash.com/photo-1468421870903-4df1664ac249?auto=format&fit=crop&w=800&q=80',
        features: ['Econômico', 'Prático'],
      ),
      BoatModel(
        id: '8',
        name: 'Lancha Luxuosa',
        location: 'Ilhabela, SP',
        price: 3000.0,
        rating: 5.0,
        imageUrl: 'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
        features: ['Luxo', 'Jacuzzi', 'Bar'],
      ),
      BoatModel(
        id: '9',
        name: 'Barco para Eventos',
        location: 'Vitória, ES',
        price: 3500.0,
        rating: 4.4,
        imageUrl: 'https://images.unsplash.com/photo-1465414829459-d228b58caf6e?auto=format&fit=crop&w=800&q=80',
        features: ['Eventos', 'Espaçoso', 'Bar'],
      ),
      BoatModel(
        id: '10',
        name: 'Iate Premium',
        location: 'Fortaleza, CE',
        price: 5000.0,
        rating: 5.0,
        imageUrl: 'https://images.unsplash.com/photo-1464037866556-6812c9d1c72e?auto=format&fit=crop&w=800&q=80',
        features: ['Premium', 'Luxo', 'Piscina'],
      ),
    ];
  }
}

class _FiltersModal extends StatefulWidget {
  final RangeValues priceRange;
  final int capacity;
  final double minRating;
  final List<String> selectedCategories;
  final List<String> selectedAmenities;
  final String selectedOrder;
  final void Function(RangeValues, int, double, List<String>, List<String>, String) onApply;

  const _FiltersModal({
    required this.priceRange,
    required this.capacity,
    required this.minRating,
    required this.selectedCategories,
    required this.selectedAmenities,
    required this.selectedOrder,
    required this.onApply,
  });

  @override
  State<_FiltersModal> createState() => _FiltersModalState();
}

class _FiltersModalState extends State<_FiltersModal> {
  late RangeValues _priceRange;
  late int _capacity;
  late double _minRating;
  late List<String> _selectedCategories;
  late List<String> _selectedAmenities;
  late String _selectedOrder;

  final List<String> _allCategories = ['Luxo', 'Esporte', 'Família', 'Romântico'];
  final List<String> _allAmenities = ['Piscina', 'Bar', 'Jacuzzi', 'Churrasqueira'];
  final List<String> _orders = ['Relevância', 'Preço (menor)', 'Preço (maior)', 'Avaliação'];

  @override
  void initState() {
    super.initState();
    _priceRange = widget.priceRange;
    _capacity = widget.capacity;
    _minRating = widget.minRating;
    _selectedCategories = List.from(widget.selectedCategories);
    _selectedAmenities = List.from(widget.selectedAmenities);
    _selectedOrder = widget.selectedOrder;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filtros Avançados', style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.lg),
            Text('Faixa de Preço (R\$)', style: AppTypography.bodyMedium),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 10000,
              divisions: 100,
              labels: RangeLabels(
                _priceRange.start.round().toString(),
                _priceRange.end.round().toString(),
              ),
              onChanged: (values) => setState(() => _priceRange = values),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Capacidade', style: AppTypography.bodyMedium),
            Row(
              children: [
                IconButton(
                  onPressed: _capacity > 1 ? () => setState(() => _capacity--) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$_capacity', style: AppTypography.titleMedium),
                IconButton(
                  onPressed: _capacity < 50 ? () => setState(() => _capacity++) : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Categorias', style: AppTypography.bodyMedium),
            Wrap(
              spacing: 8,
              children: _allCategories.map((cat) => FilterChip(
                label: Text(cat),
                selected: _selectedCategories.contains(cat),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedCategories.add(cat);
                    } else {
                      _selectedCategories.remove(cat);
                    }
                  });
                },
              )).toList(),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Comodidades', style: AppTypography.bodyMedium),
            Wrap(
              spacing: 8,
              children: _allAmenities.map((amen) => FilterChip(
                label: Text(amen),
                selected: _selectedAmenities.contains(amen),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedAmenities.add(amen);
                    } else {
                      _selectedAmenities.remove(amen);
                    }
                  });
                },
              )).toList(),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Avaliação mínima', style: AppTypography.bodyMedium),
            Slider(
              value: _minRating,
              min: 0,
              max: 5,
              divisions: 5,
              label: _minRating.toStringAsFixed(1),
              onChanged: (value) => setState(() => _minRating = value),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Ordenar por', style: AppTypography.bodyMedium),
            DropdownButton<String>(
              value: _selectedOrder,
              isExpanded: true,
              items: _orders.map((order) => DropdownMenuItem(
                value: order,
                child: Text(order),
              )).toList(),
              onChanged: (value) => setState(() => _selectedOrder = value!),
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApply(
                    _priceRange,
                    _capacity,
                    _minRating,
                    _selectedCategories,
                    _selectedAmenities,
                    _selectedOrder,
                  );
                },
                child: const Text('Aplicar Filtros'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 