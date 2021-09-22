part of 'services.dart';

class AuthServices {
  static fa.FirebaseAuth _firebaseAuth = fa.FirebaseAuth.instance;

  static Future<SignInSignUpResponse> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      fa.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

      await UserServices.updateUser(user);

      return SignInSignUpResponse(user: user);
    } catch (e) {
      return SignInSignUpResponse(message: e.toString().split(',').elementAt(0));
    }
  }

  static Future<SignInSignUpResponse> signIn(
      String email, String password) async {
    try {
      fa.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User user = await userCredential.user.fromFireStore();

      return SignInSignUpResponse(user: user);
    } catch (e) {
      return SignInSignUpResponse(message: e.toString().split(',').elementAt(0));
    }
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

class SignInSignUpResponse {
  final User user;
  final String message;

  SignInSignUpResponse({this.user, this.message});
}
