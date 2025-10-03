import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../design_system/components/buttons/app_button.dart';
import '../../../design_system/components/cards/glass_card.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../domain/models/detailed_review_model.dart';

class DetailedReviewScreen extends StatefulWidget {
  final String boatId;
  final String boatName;

  const DetailedReviewScreen({
    super.key,
    required this.boatId,
    required this.boatName,
  });

  @override
  State<DetailedReviewScreen> createState() => _DetailedReviewScreenState();
}

class _DetailedReviewScreenState extends State<DetailedReviewScreen> {
  final Map<ReviewCriteria, double> _ratings = {};
  final TextEditingController _commentController = TextEditingController();
  final List<String> _selectedHighlights = [];
  final List<String> _selectedImprovements = [];
  final List<String> _photos = [];

  final List<String> _availableHighlights = [
    'Barco muito limpo',
    'Proprietário atencioso',
    'Localização excelente',
    'Ótimo custo-benefício',
    'Equipamentos em perfeito estado',
    'Vista incrível',
    'Fácil acesso',
    'Experiência inesquecível',
  ];

  final List<String> _availableImprovements = [
    'Melhorar limpeza',
    'Comunicação mais clara',
    'Atualizar fotos do anúncio',
    'Melhorar equipamentos',
    'Facilitar acesso',
    'Reduzir preço',
    'Mais comodidades',
    'Melhor localização',
  ];

  @override
  void initState() {
    super.initState();
    // Inicializar ratings com 0
    for (final criteria in ReviewCriteria.values) {
      _ratings[criteria] = 0.0;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliar Experiência'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBoatInfo(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildRatingsSection(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildCommentSection(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildHighlightsSection(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildImprovementsSection(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildPhotosSection(theme),
            const SizedBox(height: AppSpacing.xl),
            _buildSubmitButton(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildBoatInfo(ThemeData theme) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(
                Icons.directions_boat_rounded,
                color: theme.colorScheme.onPrimaryContainer,
                size: 30,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.boatName,
                    style: AppTypography.titleLarge.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Como foi sua experiência?',
                    style: AppTypography.bodyMedium.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildRatingsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Avalie cada aspecto',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Sua avaliação detalhada ajuda outros usuários',
          style: AppTypography.bodyMedium.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ...ReviewCriteria.values.map((criteria) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: _buildRatingItem(theme, criteria),
          );
        }).toList(),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildRatingItem(ThemeData theme, ReviewCriteria criteria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          criteria.displayName,
          style: AppTypography.titleMedium.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.semiBold,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          criteria.description,
          style: AppTypography.bodySmall.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: List.generate(5, (index) {
            final starValue = index + 1.0;
            final isSelected = _ratings[criteria]! >= starValue;
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  _ratings[criteria] = starValue;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: Icon(
                  isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: isSelected 
                      ? AppColors.tertiaryGold500 
                      : theme.colorScheme.outline,
                  size: 32,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCommentSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conte mais sobre sua experiência',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: TextField(
            controller: _commentController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Descreva sua experiência com detalhes...',
              hintStyle: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(AppSpacing.lg),
            ),
            style: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildHighlightsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'O que mais gostou?',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Selecione os pontos positivos',
          style: AppTypography.bodyMedium.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _availableHighlights.map((highlight) {
            final isSelected = _selectedHighlights.contains(highlight);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedHighlights.remove(highlight);
                  } else {
                    _selectedHighlights.add(highlight);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.success500.withOpacity(0.1)
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.success500
                        : theme.colorScheme.outline,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected)
                      Icon(
                        Icons.check_circle_rounded,
                        size: 16,
                        color: AppColors.success500,
                      ),
                    if (isSelected) const SizedBox(width: AppSpacing.xs),
                    Text(
                      highlight,
                      style: AppTypography.labelMedium.copyWith(
                        color: isSelected
                            ? AppColors.success500
                            : theme.colorScheme.onSurface,
                        fontWeight: isSelected
                            ? AppTypography.semiBold
                            : AppTypography.medium,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildImprovementsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'O que pode melhorar?',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Sugestões construtivas (opcional)',
          style: AppTypography.bodyMedium.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _availableImprovements.map((improvement) {
            final isSelected = _selectedImprovements.contains(improvement);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedImprovements.remove(improvement);
                  } else {
                    _selectedImprovements.add(improvement);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.secondaryOrange500.withOpacity(0.1)
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.secondaryOrange500
                        : theme.colorScheme.outline,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected)
                      Icon(
                        Icons.lightbulb_rounded,
                        size: 16,
                        color: AppColors.secondaryOrange500,
                      ),
                    if (isSelected) const SizedBox(width: AppSpacing.xs),
                    Text(
                      improvement,
                      style: AppTypography.labelMedium.copyWith(
                        color: isSelected
                            ? AppColors.secondaryOrange500
                            : theme.colorScheme.onSurface,
                        fontWeight: isSelected
                            ? AppTypography.semiBold
                            : AppTypography.medium,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(delay: 800.ms);
  }

  Widget _buildPhotosSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adicionar fotos',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Compartilhe fotos da sua experiência (opcional)',
          style: AppTypography.bodyMedium.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        GestureDetector(
          onTap: () {
            // Implementar seleção de fotos
          },
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: theme.colorScheme.outline,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_rounded,
                    size: 40,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Toque para adicionar fotos',
                    style: AppTypography.bodyMedium.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1000.ms);
  }

  Widget _buildSubmitButton(ThemeData theme) {
    final hasMinimumRating = _ratings.values.any((rating) => rating > 0);
    
    return AppButton(
      text: 'Publicar Avaliação',
      onPressed: hasMinimumRating ? _submitReview : null,
      customChild: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.send_rounded,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Publicar Avaliação',
            style: AppTypography.labelLarge.copyWith(
              color: Colors.white,
              fontWeight: AppTypography.bold,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 1200.ms);
  }

  void _submitReview() {
    // Implementar envio da avaliação
    final review = DetailedReview(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'current_user_id',
      userName: 'Usuário Atual',
      userAvatar: 'https://randomuser.me/api/portraits/men/1.jpg',
      boatId: widget.boatId,
      boatName: widget.boatName,
      ratings: Map.from(_ratings),
      comment: _commentController.text,
      photos: List.from(_photos),
      createdAt: DateTime.now(),
      isVerified: true,
      highlights: List.from(_selectedHighlights),
      improvements: List.from(_selectedImprovements),
    );

    // Aqui seria enviado para o backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Avaliação enviada com sucesso!'),
        backgroundColor: AppColors.success500,
      ),
    );

    Navigator.of(context).pop();
  }
}
