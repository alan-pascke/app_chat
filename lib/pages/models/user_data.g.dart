// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      userId: json['userId'] as String,
      senderName: json['senderName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'userId': instance.userId,
      'senderName': instance.senderName,
      'userPhotoUrl': instance.userPhotoUrl,
    };
