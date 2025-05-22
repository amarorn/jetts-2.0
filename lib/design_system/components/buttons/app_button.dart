import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';

enum AppButtonType {
  primary,
  secondary,
  ghost,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final Widget? customChild;
  final bool isLoading;
  final bool isFullWidth;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.customChild,
    this.isLoading = false,
    this.isFullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    switch (type) {
      case AppButtonType.primary:
        return _buildPrimaryButton(theme);
      case AppButtonType.secondary:
        return _buildSecondaryButton(theme);
      case AppButtonType.ghost:
        return _buildGhostButton(theme);
    }
  }

  Widget _buildPrimaryButton(ThemeData theme) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        disabledBackgroundColor: theme.colorScheme.outline,
        disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: isFullWidth ? const Size(double.infinity, 56) : const Size(56, 56),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
      child: _buildButtonContent(theme),
    );
  }

  Widget _buildSecondaryButton(ThemeData theme) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: theme.colorScheme.primary,
        disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
        minimumSize: isFullWidth ? const Size(double.infinity, 56) : const Size(56, 56),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        side: BorderSide(color: theme.colorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
      child: _buildButtonContent(theme),
    );
  }

  Widget _buildGhostButton(ThemeData theme) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.primary,
        disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
        minimumSize: isFullWidth ? const Size(double.infinity, 56) : const Size(56, 56),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
      child: _buildButtonContent(theme),
    );
  }

  Widget _buildButtonContent(ThemeData theme) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == AppButtonType.primary
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.primary,
          ),
        ),
      );
    }

    if (customChild != null) {
      return customChild!;
    }

    return Text(
      text,
      style: AppTypography.labelLarge.copyWith(
        color: type == AppButtonType.primary
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.primary,
        fontWeight: AppTypography.semiBold,
      ),
    );
  }
} 