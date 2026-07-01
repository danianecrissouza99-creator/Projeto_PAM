/// Constantes da API RAWG (endereço base e endpoints).
class ApiConstants {
  ApiConstants._(); // impede que se crie um objeto desta classe

  static const String baseUrl = 'https://api.rawg.io/api';

  // Endpoints que vamos consumir
  static const String games = '/games';        // lista e pesquisa de jogos
  static const String platforms = '/platforms'; // lista de plataformas (filtro)
}