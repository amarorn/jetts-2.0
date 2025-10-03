#!/bin/bash

# Script para Publicação no Firebase App Distribution
# Execute este script no seu ambiente local após fazer o build

echo "🚀 Script de Publicação - Firebase App Distribution"
echo "=================================================="

# Informações do projeto
PROJECT_ID="jetss-1e0f9"
APP_ID="1:653955515555:android:039ff4adf450462fb7eb16"
APK_PATH="build/app/outputs/flutter-apk/app-release.apk"

echo "📋 Informações do Projeto:"
echo "Project ID: $PROJECT_ID"
echo "App ID: $APP_ID"
echo "APK Path: $APK_PATH"
echo ""

# Verificar se está logado no Firebase
echo "🔐 Verificando login no Firebase..."
if ! firebase projects:list > /dev/null 2>&1; then
    echo "❌ Não está logado no Firebase. Fazendo login..."
    firebase login
else
    echo "✅ Já está logado no Firebase"
fi

# Verificar se o APK existe
echo ""
echo "📱 Verificando se o APK existe..."
if [ ! -f "$APK_PATH" ]; then
    echo "❌ APK não encontrado. Fazendo build..."
    echo "Executando: flutter clean && flutter pub get && flutter build apk --release"
    flutter clean
    flutter pub get
    flutter build apk --release
    
    if [ ! -f "$APK_PATH" ]; then
        echo "❌ Falha ao gerar o APK. Verifique os erros acima."
        exit 1
    fi
else
    echo "✅ APK encontrado: $APK_PATH"
fi

# Inicializar Firebase App Distribution (se necessário)
echo ""
echo "🔧 Verificando configuração do Firebase..."
if [ ! -f ".firebaserc" ]; then
    echo "Inicializando Firebase App Distribution..."
    firebase init appdistribution --project $PROJECT_ID
fi

# Fazer a distribuição
echo ""
echo "📤 Fazendo upload do APK para Firebase App Distribution..."
echo "Comando: firebase appdistribution:distribute $APK_PATH --app $APP_ID"

# Solicitar informações do usuário
read -p "📝 Digite as notas da versão: " RELEASE_NOTES
read -p "📧 Digite os emails dos testadores (separados por vírgula): " TESTERS

# Executar a distribuição
firebase appdistribution:distribute "$APK_PATH" \
    --app "$APP_ID" \
    --release-notes "$RELEASE_NOTES" \
    --testers "$TESTERS"

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Sucesso! APK distribuído com sucesso!"
    echo "🌐 Acesse o console: https://console.firebase.google.com/project/$PROJECT_ID/appdistribution"
    echo "📧 Os testadores receberão um email com instruções para download"
else
    echo ""
    echo "❌ Erro na distribuição. Verifique os logs acima."
    exit 1
fi

echo ""
echo "✅ Processo concluído!"
