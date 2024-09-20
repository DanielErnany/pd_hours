### PD Hours Control

**Descrição**

O PD Hours é um sistema desenvolvido para o teste prático da PD Soluções para controle de horas de equipes. Permite que funcionários registrem suas atividades diárias, incluindo descrição e tempo gasto.

* **Tecnologia:** Flutter 3.3.4
* **Plataformas:** Mobile (Android) e Desktop (Windows/macOS/Linux)

**Requisitos**

* Flutter SDK 3.3.4
* Dart SDK
* Android Studio ou VS Code
* Emulador/dispositivo físico (mobile)
* Desktop (para versão desktop)

**Instalação**

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/DanielErnany/pd_hours.git
   ```
2. **Navegue para o diretório:**
   ```bash
   cd pd_hours
   ```
3. **Verifique a versão do Flutter:**
   ```bash
   flutter --version
   ```
4. **Atualize para a versão 3.3.4 (se necessário):**
   ```bash
   flutter downgrade 3.3.4
   ```
5. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

**Execução**

* **Mobile:**
   ```bash
   flutter run
   ```
   * Para um dispositivo específico:
     ```bash
     flutter run -d <device-id>
     ```
* **Desktop:**
   * **Habilitar suporte a desktop:**
     ```bash
     flutter config --enable-<plataforma>-desktop
     ```
     (Substitua `<plataforma>` por `windows`, `macos` ou `linux`)
   * **Executar:**
     ```bash
     flutter run -d <plataforma>
     ```

**Build**

* **Mobile:**
   * **Android:**
     ```bash
     flutter build apk
     ```
* **Desktop:**
   ```bash
   flutter build <plataforma>
   ```
