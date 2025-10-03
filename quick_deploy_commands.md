# Comandos Rápidos para Publicação no Firebase 🚀

## Opção 1: Script Automatizado
```bash
# Copie o script firebase_deploy_script.sh para o diretório do projeto
# e execute:
./firebase_deploy_script.sh
```

## Opção 2: Comandos Manuais

### 1. Login no Firebase
```bash
firebase login
```

### 2. Build do APK
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### 3. Distribuição
```bash
firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
    --app 1:653955515555:android:039ff4adf450462fb7eb16 \
    --release-notes "Primeira versão do Jetts para teste" \
    --testers "seu-email@gmail.com,testador@gmail.com"
```

## Opção 3: Distribuição para Grupos
```bash
# Primeiro, criar um grupo de testadores
firebase appdistribution:group:create equipe-desenvolvimento \
    --project jetss-1e0f9

# Adicionar testadores ao grupo
firebase appdistribution:testers:add email1@gmail.com email2@gmail.com \
    --project jetss-1e0f9

# Distribuir para o grupo
firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
    --app 1:653955515555:android:039ff4adf450462fb7eb16 \
    --release-notes "Nova versão" \
    --groups "equipe-desenvolvimento"
```

## Informações do Projeto
- **Project ID:** `jetss-1e0f9`
- **App ID:** `1:653955515555:android:039ff4adf450462fb7eb16`
- **Console:** https://console.firebase.google.com/project/jetss-1e0f9/appdistribution

## Resolução de Problemas

### Se o build falhar:
```bash
# Limpar cache e tentar novamente
flutter clean
flutter pub get
flutter doctor
flutter build apk --release --verbose
```

### Se a distribuição falhar:
```bash
# Verificar login
firebase login --reauth

# Verificar projetos
firebase projects:list

# Verificar se o arquivo existe
ls -la build/app/outputs/flutter-apk/
```

### Dependências Removidas Temporariamente
Para restaurar as funcionalidades completas, descomente no `pubspec.yaml`:
```yaml
flutter_local_notifications: ^17.0.0  # Versão mais recente
speech_to_text: ^7.0.0                # Versão mais recente
timezone: ^0.10.0                      # Versão mais recente
```

E descomente o código relacionado em:
- `lib/main.dart`
- `lib/presentation/pages/search/search_screen.dart`
