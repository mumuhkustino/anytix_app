part of 'services.dart';

class AuthServices {

  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
      String email,
      String password,
      String name,
      List<String> selectedGenres,
      String selectedLanguage) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User user = authResult.user.convertToUserModel(
        name: name,
        selectedGenres: selectedGenres,
        selectedLanguage: selectedLanguage
      );

      await UserServices.updateUser(user);

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1]);
    }
  }

  static Future<SignInSignUpResult> signIn(String email, String password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);

      User user = await authResult.user.fromFireStore();

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1]);
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

}

class SignInSignUpResult {

  final User user;
  final String message;

  SignInSignUpResult({this.user, this.message});

}