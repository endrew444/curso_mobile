Descrição

Aplicativo mobile que permite registrar o ponto de trabalho quando o funcionário estiver a até 100 metros do local de trabalho.

Autenticação segura por NIF e senha via Firebase Authentication.

Registro de ponto em tempo real com data, hora e localização no Firebase Firestore.

Exibição da localização do usuário no mapa usando OpenStreetMap.

 Funcionalidades

Login por NIF e senha.

Verificação de proximidade ao local de trabalho (100 metros).

Registro de ponto com data, hora e localização.

Visualização da localização no mapa via OpenStreetMap.

Armazenamento em tempo real no Firebase.

🛠 Tecnologias Utilizadas

Flutter – Desenvolvimento mobile cross-platform.

Firebase Authentication – Autenticação de usuários.

Firebase Firestore – Armazenamento de registros em tempo real.

Geolocator – Captura de localização do usuário.

Flutter Map / OpenStreetMap – Exibição de mapas.

 Estrutura do Projeto
lib/
│
├─ controllers/  → Lógica de autenticação e registro de ponto
├─ models/       → Modelos de dados
├─ views/        → Telas do aplicativo
└─ main.dart     → Ponto de entrada do app
pubspec.yaml     → Dependências do projeto

 Como Rodar o Projeto
# Clone o repositório
git clone <URL_DO_REPOSITORIO>

# Entre na pasta do projeto
cd nome-do-projeto

# Instale as dependências
flutter pub get

# Configure o Firebase
# (adicione seu google-services.json ou GoogleService-Info.plist conforme o ambiente)

# Execute o aplicativo
flutter run

 Considerações

O registro de ponto só é permitido se o usuário estiver dentro de 100 metros do local de trabalho.

A localização é exibida no mapa usando OpenStreetMap.

Todos os dados de ponto são armazenados no Firebase em tempo real.