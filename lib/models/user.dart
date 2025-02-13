import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show immutable;
import 'package:path_provider/path_provider.dart'; // Import path_provider

@immutable
class UserModel {
  final String fullName;
  final DateTime birthDay;
  final String gender;
  final String email;
  final String password;
  final String profilePicUrl;
  final String uid;
  final List<String> friends;
  final List<String> sentRequests;
  final List<String> receivedRequests;

  const UserModel({
    required this.fullName,
    required this.birthDay,
    required this.gender,
    required this.email,
    required this.password,
    required this.profilePicUrl,
    required this.uid,
    required this.friends,
    required this.sentRequests,
    required this.receivedRequests,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'birthDay': birthDay.millisecondsSinceEpoch,
      'gender': gender,
      'email': email,
      'password': password,
      'profilePicUrl': profilePicUrl,
      'uid': uid,
      'friends': friends,
      'sentRequests': sentRequests,
      'receivedRequests': receivedRequests,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] as String,
      birthDay: DateTime.fromMillisecondsSinceEpoch(map['birthDay'] as int),
      gender: map['gender'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profilePicUrl: map['profilePicUrl'] as String,
      uid: map['uid'] as String,
      friends: List<String>.from((map['friends'] ?? [])),
      sentRequests: List<String>.from((map['sentRequests'] ?? [])),
      receivedRequests: List<String>.from((map['receivedRequests'] ?? [])),
    );
  }

  Future<void> saveToJson() async {
    final directory =
        await getApplicationDocumentsDirectory(); // Get the app's document directory
    final file = File(
        '${directory.path}/models/jentalaw.json'); // Construct the file path
    final jsonString = jsonEncode(toMap());
    await file.writeAsString(jsonString);
  }

  static Future<UserModel?> loadFromJson() async {
    final directory =
        await getApplicationDocumentsDirectory(); // Get the app's document directory
    final file = File(
        '${directory.path}/models/jentalaw.json'); // Construct the file path
    if (await file.exists()) {
      final jsonString = await file.readAsString();
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return UserModel.fromMap(jsonMap);
    }
    return null; // Return null if file doesn't exist
  }
}
