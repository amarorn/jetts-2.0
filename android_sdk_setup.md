# Configuração do Android SDK - Solução para o Erro

## Problema Identificado
```
[!] No Android SDK found. Try setting the ANDROID_HOME environment var
```

## Soluções por Sistema Operacional

### 🍎 macOS (Seu caso)

#### Opção 1: Instalar Android Studio (Recomendado)
1. **Baixe o Android Studio:**
   - Acesse: https://developer.android.com/studio
   - Baixe e instale o Android Studio

2. **Configure o SDK:**
   - Abra o Android Studio
   - Vá em **Preferences** > **Appearance & Behavior** > **System Settings** > **Android SDK**
   - Instale pelo menos o **Android API 33** ou superior
   - Anote o caminho do SDK (geralmente: `/Users/SEU_USUARIO/Library/Android/sdk`)

3. **Configure as variáveis de ambiente:**
   ```bash
   # Adicione ao seu ~/.zshrc ou ~/.bash_profile
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/emulator
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/tools/bin
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   ```

4. **Recarregue o terminal:**
   ```bash
   source ~/.zshrc  # ou source ~/.bash_profile
   ```

#### Opção 2: Instalar apenas Command Line Tools
1. **Baixe as Command Line Tools:**
   ```bash
   # Crie o diretório
   mkdir -p $HOME/Library/Android/sdk
   cd $HOME/Library/Android/sdk
   
   # Baixe as command line tools
   wget https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip
   unzip commandlinetools-mac-11076708_latest.zip
   mkdir -p cmdline-tools/latest
   mv cmdline-tools/* cmdline-tools/latest/
   ```

2. **Configure as variáveis:**
   ```bash
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   ```

3. **Instale os componentes necessários:**
   ```bash
   sdkmanager --licenses
   sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"
   ```

### 🐧 Linux

#### Configuração para Linux:
```bash
# Instalar dependências
sudo apt update
sudo apt install openjdk-11-jdk

# Baixar Android SDK
mkdir -p $HOME/Android/Sdk
cd $HOME/Android/Sdk
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-11076708_latest.zip
mkdir -p cmdline-tools/latest
mv cmdline-tools/* cmdline-tools/latest/

# Configurar variáveis
echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.bashrc
source ~/.bashrc

# Instalar componentes
sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"
```

### 🪟 Windows

#### Configuração para Windows:
1. **Instale o Android Studio** ou baixe as Command Line Tools
2. **Configure as variáveis de ambiente:**
   - Vá em **Configurações do Sistema** > **Variáveis de Ambiente**
   - Adicione:
     - `ANDROID_HOME`: `C:\Users\SEU_USUARIO\AppData\Local\Android\Sdk`
     - Adicione ao `PATH`: `%ANDROID_HOME%\platform-tools` e `%ANDROID_HOME%\cmdline-tools\latest\bin`

## Verificação da Instalação

Após a configuração, execute:

```bash
# Verificar se o Android SDK foi encontrado
flutter doctor

# Verificar variáveis de ambiente
echo $ANDROID_HOME
adb --version
```

## Script Atualizado para Verificar SDK

Crie um arquivo `check_android_sdk.sh`:

```bash
#!/bin/bash

echo "🔍 Verificando configuração do Android SDK..."

# Verificar ANDROID_HOME
if [ -z "$ANDROID_HOME" ]; then
    echo "❌ ANDROID_HOME não está definido"
    echo "💡 Configure com: export ANDROID_HOME=/caminho/para/android/sdk"
    exit 1
else
    echo "✅ ANDROID_HOME: $ANDROID_HOME"
fi

# Verificar se o diretório existe
if [ ! -d "$ANDROID_HOME" ]; then
    echo "❌ Diretório do Android SDK não existe: $ANDROID_HOME"
    exit 1
else
    echo "✅ Diretório do Android SDK encontrado"
fi

# Verificar adb
if command -v adb &> /dev/null; then
    echo "✅ ADB encontrado: $(adb --version | head -1)"
else
    echo "❌ ADB não encontrado no PATH"
    exit 1
fi

# Verificar Flutter Doctor
echo ""
echo "🔍 Executando flutter doctor..."
flutter doctor

echo ""
echo "✅ Verificação concluída! Se tudo estiver OK, execute novamente:"
echo "./firebase_deploy_script.sh"
```

## Comandos Rápidos para Resolver

**Para macOS (seu caso):**
```bash
# 1. Instalar Android Studio (mais fácil)
# Ou usar Homebrew:
brew install --cask android-studio

# 2. Configurar variáveis (adicione ao ~/.zshrc)
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools

# 3. Recarregar terminal
source ~/.zshrc

# 4. Verificar
flutter doctor
```

Depois de configurar o Android SDK, execute novamente:
```bash
./firebase_deploy_script.sh
```
