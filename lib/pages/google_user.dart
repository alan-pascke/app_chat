// ignore_for_file: unused_element

import 'package:app_chat/pages/chat_screen.dart';
import 'package:app_chat/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleUser {
  GoogleUser();

  final GoogleSignIn googleSignIn = GoogleSignIn();
  User? _currentUser;

  Future<User?> getUser() async {
    if (_currentUser != null) return _currentUser!;

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User user = authResult.user!;
      return user;
    } catch (e) {
      return null;
    }
  }

  void returnUserToChat() async {
    ChatScreen(
      getUser: await getUser() as Future,
      currentUser: _currentUser,
    );
  }

  void returnUsertoLoginPage() {
    LoginPage(
      getUser: getUser(),
      currentUser: _currentUser,
    );
  }
}
