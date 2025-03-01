class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/";

  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getAllStudent = "auth/getAllStudents";
  static const String updateStudent = "auth/updateStudent/";
  static const String deleteStudent = "auth/deleteStudent/";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";

  static const String createTournament = "tournaments/registerGames";
  static const String getTournamentsByGame = "tournaments/";
  static const String getTournamentNamesByGame = "tournaments/names/";
  static const String getGameList = "games/games";
  static const String getGameNamesList = "gamesname";
  static const String getAllGameNames = "games/allnames"; // New endpoint

  static const String registerPlayer = "player/registerPlayer";
  static const String getRegisteredPlayers = "player/registered";

  static const String getMatchups = "matchups/matchup";
  static const String getUniqueTournaments = "matchups/tournaments";

  // History Endpoints
  static const String getWinners = "winners/winners";

  // Profile Endpoints
  static const String getMe = "auth/getMe"; // Add this line
}
