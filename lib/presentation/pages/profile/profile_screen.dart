import 'package:flutter/material.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../design_system/tokens/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () {
              // Navegar para editar perfil
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar e nome
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('João Silva', style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: AppSpacing.xs),
                  Text('joao@email.com', style: AppTypography.bodyMedium.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Atalhos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ProfileShortcut(
                  icon: Icons.favorite_rounded,
                  label: 'Favoritos',
                  onTap: () => Navigator.of(context).pushNamed('/favorites'),
                ),
                _ProfileShortcut(
                  icon: Icons.calendar_today_rounded,
                  label: 'Reservas',
                  onTap: () {},
                ),
                _ProfileShortcut(
                  icon: Icons.support_agent_rounded,
                  label: 'Suporte',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            // Informações pessoais
            _ProfileSectionTitle('Informações'),
            const SizedBox(height: AppSpacing.md),
            _ProfileInfoRow(icon: Icons.phone_rounded, label: 'Telefone', value: '(21) 99999-9999'),
            _ProfileInfoRow(icon: Icons.cake_rounded, label: 'Nascimento', value: '01/01/1990'),
            _ProfileInfoRow(icon: Icons.location_on_rounded, label: 'Cidade', value: 'Rio de Janeiro, RJ'),
            const SizedBox(height: AppSpacing.xl),
            // Configurações
            _ProfileSectionTitle('Configurações'),
            const SizedBox(height: AppSpacing.md),
            _ProfileSettingsTile(
              icon: Icons.notifications_active_rounded,
              label: 'Notificações',
              value: true,
              onChanged: (v) {},
            ),
            _ProfileSettingsTile(
              icon: Icons.dark_mode_rounded,
              label: 'Tema escuro',
              value: false,
              onChanged: (v) {},
            ),
            _ProfileSettingsTile(
              icon: Icons.language_rounded,
              label: 'Idioma',
              value: false,
              onChanged: (v) {},
              trailing: const Text('Português'),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Logout
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Implementar logout
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Sair'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                  side: BorderSide(color: theme.colorScheme.error),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileShortcut extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ProfileShortcut({required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 28),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: AppTypography.bodySmall),
        ],
      ),
    );
  }
}

class _ProfileSectionTitle extends StatelessWidget {
  final String title;
  const _ProfileSectionTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ProfileInfoRow({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: AppSpacing.md),
          Text('$label:', style: AppTypography.bodyMedium),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(value, style: AppTypography.bodyMedium.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ),
        ],
      ),
    );
  }
}

class _ProfileSettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? trailing;
  const _ProfileSettingsTile({required this.icon, required this.label, required this.value, required this.onChanged, this.trailing});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(label, style: AppTypography.bodyMedium),
      trailing: trailing ?? Switch(value: value, onChanged: onChanged),
      onTap: trailing != null ? null : () => onChanged(!value),
    );
  }
} 