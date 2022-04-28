// ignore_for_file: must_be_immutable

import 'package:app_chat/pages/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.getUser, this.currentUser}) : super(key: key);

  User? currentUser;
  Future? getUser;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      widget.currentUser = user;
    });
  }

  void _signIn() async {
    final User? user = await widget.getUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possivel fazer login',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey,
        ),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          height: 60,
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              _signIn();
            },
            child: const Text('Entrar'),
          ),
        ),
      ),
    );
  }
}
