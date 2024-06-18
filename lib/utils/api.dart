class Apis {
  // authentication releted apis
  static String baseUrl = 'https://notes-app-yudo.onrender.com';
  static String logIn = '$baseUrl/user/login';
  static String signIn = '$baseUrl/user/signUp';

  // notes releted apis
  static String createNote = '$baseUrl/note';
  static String fetchNotes = '$baseUrl/note';

  // notes releted apis which uses id
  static String deleteNotes = '$baseUrl/note';
  static String editNotes = '$baseUrl/note';
}
