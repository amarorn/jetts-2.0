#!/bin/bash

# Script para Build e Distribuição iOS - Firebase App Distribution
# Execute este script no seu ambiente local

echo "🍎 Script de Build e Distribuição iOS"
echo "====================================="

# Informações do projeto
PROJECT_ID="jetss-1e0f9"
IOS_APP_ID="1:653955515555:ios:399057bd2518d067b7eb16"
BUNDLE_ID="com.example.jetts_2_0"
IPA_PATH="build/ios/ipa/jetts_2_0.ipa"

echo "📋 Informações do Projeto iOS:"
echo "Project ID: $PROJECT_ID"
echo "iOS App ID: $IOS_APP_ID"
echo "Bundle ID: $BUNDLE_ID"
echo "IPA Path: $IPA_PATH"
echo ""

# Verificar se está logado no Firebase
echo "🔐 Verificando login no Firebase..."
if ! firebase projects:list > /dev/null 2>&1; then
    echo "❌ Não está logado no Firebase. Fazendo login..."
    firebase login
else
    echo "✅ Já está logado no Firebase"
fi

# Verificar se o Flutter está funcionando
echo ""
echo "🔍 Verificando Flutter..."
flutter doctor

# Limpar e preparar
echo ""
echo "🧹 Limpando projeto..."
flutter clean
flutter pub get

# Verificar se o IPA existe
echo ""
echo "📱 Verificando se o IPA existe..."
if [ ! -f "$IPA_PATH" ]; then
    echo "❌ IPA não encontrado. Fazendo build..."
    echo "Executando: flutter build ipa --release"
    
    # Build iOS
    flutter build ipa --release
    
    if [ ! -f "$IPA_PATH" ]; then
        echo "❌ Falha ao gerar o IPA. Verifique os erros acima."
        echo ""
        echo "💡 Possíveis soluções:"
        echo "1. Abra o projeto no Xcode: open ios/Runner.xcworkspace"
        echo "2. Configure o Team de desenvolvimento"
        echo "3. Verifique se o GoogleService-Info.plist foi adicionado"
        echo "4. Tente fazer archive manual no Xcode"
        exit 1
    fi
else
    echo "✅ IPA encontrado: $IPA_PATH"
fi

# Fazer a distribuição
echo ""
echo "📤 Fazendo upload do IPA para Firebase App Distribution..."
echo "Comando: firebase appdistribution:distribute $IPA_PATH --app $IOS_APP_ID"

# Solicitar informações do usuário
read -p "📝 Digite as notas da versão iOS: " RELEASE_NOTES
read -p "📧 Digite os emails dos testadores (separados por vírgula): " TESTERS

# Executar a distribuição
firebase appdistribution:distribute "$IPA_PATH" \
    --app "$IOS_APP_ID" \
    --release-notes "$RELEASE_NOTES" \
    --testers "$TESTERS"

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Sucesso! IPA distribuído com sucesso!"
    echo "🌐 Acesse o console: https://console.firebase.google.com/project/$PROJECT_ID/appdistribution"
    echo "📧 Os testadores receberão um email com instruções para download"
    echo ""
    echo "📱 Instruções para testadores iOS:"
    echo "1. Abrir email no iPhone/iPad"
    echo "2. Clicar no link de download"
    echo "3. Instalar perfil de configuração"
    echo "4. Baixar e instalar o app"
    echo "5. Confiar no desenvolvedor: Configurações > Geral > Gerenciamento de Dispositivos"
else
    echo ""
    echo "❌ Erro na distribuição. Verifique os logs acima."
    echo ""
    echo "🌐 Alternativa: Use o console web"
    echo "1. Acesse: https://console.firebase.google.com/project/$PROJECT_ID/appdistribution"
    echo "2. Clique 'Upload'"
    echo "3. Selecione: $IPA_PATH"
    echo "4. Configure testadores e notas"
    exit 1
fi

echo ""
echo "✅ Processo iOS concluído!"
