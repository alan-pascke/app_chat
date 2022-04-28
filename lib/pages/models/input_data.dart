import 'package:app_chat/pages/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PutData {
  PutData(this.data);
  UserData? userData;

  Map<String, dynamic>? data;

  void getData(User? user) {
    data = {
      'uid': user!.uid,
      'senderName': user.displayName,
      'userPhotoUrl': user.photoURL,
    };
    UserData(
      userId: user.uid,
      senderName: user.displayName!,
      userPhotoUrl: user.photoURL!,
    );
  }
}
