# App de Registro de Ponto com Geolocalização

## Descrição

Este aplicativo permite que funcionários registrem seu ponto de trabalho quando estiverem a até 100 metros do local de trabalho. A autenticação é realizada por **NIF e senha** utilizando **Firebase Authentication**, e os registros de ponto são armazenados em tempo real no **Firebase Firestore**. A localização é obtida via **Geolocator** e exibida com mapas do **OpenStreetMap**.

## Funcionalidades

* Autenticação por NIF e senha.
* Verificação de localização usando geolocalização.
* Registro de ponto com data, hora e localização.
* Visualização da localização no mapa via OpenStreetMap.
* Armazenamento em tempo real no Firebase.

## Tecnologias Utilizadas

* **Flutter**: Desenvolvimento mobile.
* **Firebase Authentication**: Autenticação de usuários.
* **Firebase Firestore**: Armazenamento de registros de ponto.
* **Geolocator**: Captura de localização do usuário.
* **Flutter Map / OpenStreetMap**: Exibição de mapas.

## Como Rodar o Projeto

1. Clone este repositório;
2. Entre na pasta do projeto;
3. Instale as dependências;
4. Configure o Firebase;
5. Execute o aplicativo;

## Estrutura do Projeto

* `lib/`

  * `views/` → Telas do aplicativo.
  * `controllers/` → Lógica de autenticação e registro de ponto.
  * `models/` → Modelos de dados.
* `pubspec.yaml` → Dependências do projeto.

## Considerações

* O registro de ponto só é permitido se o usuário estiver dentro de 100 metros do local de trabalho.
* A localização é exibida no mapa usando OpenStreetMap.
* Todos os dados de ponto são armazenados no Firebase em tempo real.