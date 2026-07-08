# Games DCats

App móvel em Flutter de descoberta de jogos. Consome a API RAWG e usa Firebase (Auth + Firestore), com Clean Architecture.

## Como executar

1. Instalar dependências:
   flutter pub get

2. Configurar a chave da API RAWG:
   - Obter uma chave gratuita em https://rawg.io/apidocs
   - Copiar `lib/core/constants/api_keys.example.dart` para `lib/core/constants/api_keys.dart`
   - Substituir `A_TUA_CHAVE_AQUI` pela chave obtida

3. Firebase: a configuração (`firebase_options.dart`) já está incluída.

4. Correr a app:
   flutter run

## Testes
   flutter test