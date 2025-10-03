# Guia Completo de Distribuição - Android + iOS

## 📱 Informações dos Projetos

### Android
- **Project ID:** `jetss-1e0f9`
- **App ID:** `1:653955515555:android:039ff4adf450462fb7eb16`
- **Package Name:** `com.example.jetts_2_0`

### iOS
- **Project ID:** `jetss-1e0f9`
- **App ID:** `1:653955515555:ios:399057bd2518d067b7eb16`
- **Bundle ID:** `com.example.jetts_2_0`

## 🚀 Scripts Automatizados

### Android
```bash
./firebase_deploy_script.sh
```

### iOS
```bash
./ios_deploy_script.sh
```

## 📋 Comandos Manuais

### Android - Build e Distribuição
```bash
# Build APK
flutter clean
flutter pub get
flutter build apk --release

# Distribuir
firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
    --app 1:653955515555:android:039ff4adf450462fb7eb16 \
    --release-notes "Versão Android" \
    --testers "j.amarorn@gmail.com,rauldantas@me.com"
```

### iOS - Build e Distribuição
```bash
# Build IPA
flutter clean
flutter pub get
flutter build ipa --release

# Distribuir
firebase appdistribution:distribute build/ios/ipa/jetts_2_0.ipa \
    --app 1:653955515555:ios:399057bd2518d067b7eb16 \
    --release-notes "Versão iOS" \
    --testers "j.amarorn@gmail.com,rauldantas@me.com"
```

## 🔧 Configurações Realizadas

### Android
- ✅ Firebase configurado (`google-services.json`)
- ✅ Build.gradle configurado
- ✅ Package name: `com.example.jetts_2_0`
- ✅ Dependências problemáticas removidas temporariamente

### iOS
- ✅ Firebase configurado (`GoogleService-Info.plist`)
- ✅ Bundle ID corrigido: `com.example.jetts_2_0`
- ✅ Permissões configuradas (localização, câmera, etc.)
- ✅ Script de distribuição criado

## 🌐 Console Firebase
**Acesse:** https://console.firebase.google.com/project/jetss-1e0f9/appdistribution

## 📱 Instruções para Testadores

### Android
1. Receber email com link
2. Baixar APK
3. Instalar (permitir fontes desconhecidas se necessário)

### iOS
1. Receber email com link (abrir no iPhone/iPad)
2. Instalar perfil de configuração
3. Baixar e instalar app
4. Confiar no desenvolvedor:
   - **Configurações** > **Geral** > **Gerenciamento de Dispositivos**
   - Selecionar o desenvolvedor e **"Confiar"**

## 🔍 Resolução de Problemas

### Android SDK não encontrado:
```bash
# Configurar variáveis de ambiente
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
source ~/.zshrc

# Aceitar licenças
flutter doctor --android-licenses
```

### iOS Build falha:
1. Abrir no Xcode: `open ios/Runner.xcworkspace`
2. Configurar Team de desenvolvimento
3. Verificar se GoogleService-Info.plist foi adicionado
4. Fazer archive manual se necessário

### Firebase permissão negada:
```bash
# Reautenticar
firebase logout
firebase login

# Verificar projeto
firebase projects:list
```

## 📊 Status das Dependências

### Temporariamente Removidas (Android):
- `flutter_local_notifications` - Problema de compatibilidade
- `speech_to_text` - Erro de compilação
- `timezone` - Dependência das notificações

### Para Restaurar:
```yaml
flutter_local_notifications: ^17.0.0
speech_to_text: ^7.0.0
timezone: ^0.10.0
```

## ✅ Checklist de Distribuição

### Antes de Distribuir:
- [ ] `flutter doctor` sem erros
- [ ] Firebase CLI atualizado
- [ ] Logado no Firebase
- [ ] Build bem-sucedido

### Android:
- [ ] APK gerado em `build/app/outputs/flutter-apk/app-release.apk`
- [ ] Firebase App Distribution configurado

### iOS:
- [ ] IPA gerado em `build/ios/ipa/jetts_2_0.ipa`
- [ ] GoogleService-Info.plist adicionado no Xcode
- [ ] Team de desenvolvimento configurado

---

**🎯 Use os scripts automatizados para facilitar o processo!**
