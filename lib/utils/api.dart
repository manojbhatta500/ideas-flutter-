class Apis {
  // authentication releted apis
  static String baseUrl = 'http://localhost:3000';
  static String logIn = '$baseUrl/user/login';
  static String signIn = '$baseUrl/user/signup';

  // notes releted apis
  static String createNote = '$baseUrl/note';
  static String fetchNotes = '$baseUrl/note';

  // notes releted apis which uses id
  static String deleteNotes = '$baseUrl/note';
  static String editNotes = '$baseUrl/note';
}
