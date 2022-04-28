// ignore_for_file: avoid_print, must_be_immutable

import 'package:app_chat/pages/chat_message.dart';
import 'package:app_chat/pages/google_user.dart';
import 'package:app_chat/pages/models/input_data.dart';
import 'package:app_chat/pages/widget/text_composer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, this.getUser, this.currentUser}) : super(key: key);

  Future? getUser;
  User? currentUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      widget.currentUser = user;
    });
  }

  // Future<User?> _getUser() async {
  //   if (_currentUser != null) return _currentUser!;

  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //         idToken: googleSignInAuthentication.idToken,
  //         accessToken: googleSignInAuthentication.accessToken);
  //     final UserCredential authResult =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     final User user = authResult.user!;
  //     return user;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  void _sendMessage({String? text}) async {
    final User? user = await widget.getUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Não foi possivel fazer login',
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.grey.withOpacity(.5),
        ),
      );
    }
    PutData? putData;
    putData!.getData(user);
    Map<String, dynamic>? data = putData.data;
    // {
    //   'uid': user!.uid,
    //   'senderName': user.displayName,
    //   'userPhotoUrl': user.photoURL,
    // };
    if (text != null) data!['text'] = text;
    db.collection('messages').add(data!);

    PutData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('contacts name'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 550,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('messages')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            default:
                              List<DocumentSnapshot> documents =
                                  snapshot.data!.docs.reversed.toList();
                              return ListView.builder(
                                padding: const EdgeInsets.only(bottom: 15),
                                itemCount: documents.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: ChatMessage(
                                      documents[index].data()
                                          as Map<String, dynamic>,
                                    ),
                                  );
                                },
                              );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: TextComposer(
                      sendMessage: _sendMessage,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
