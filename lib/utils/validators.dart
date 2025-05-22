class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    if (!value.contains('@') || !value.contains('.')) return 'Email inválido';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    if (value.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    return null;
  }
} 