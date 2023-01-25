import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  Future<void> logInUser(
      {required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      print(
          'OKOKOKOKOKKKKKOKOKKOKKKKOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOR');
    } on FirebaseAuthException catch (e) {
      print(
          '-----------------------------------------------------------------------------------------------------------------------');
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }
}
