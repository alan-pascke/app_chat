// ignore_for_file: unused_local_variable

import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  //Constructor
  UserData({
    required this.userId,
    required this.senderName,
    required this.userPhotoUrl,
  });

  //Variables
  String userId;
  String senderName;
  String userPhotoUrl;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJason() => _$UserDataToJson(this);

  // void getData(User? user) {
  //   Map<String, dynamic> data = {
  //     'uid': user!.uid,
  //     'senderName': user.displayName,
  //     'userPhotoUrl': user.photoURL,
  //   };
  // }
}
