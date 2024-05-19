// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:task_manager/app/enums/gender.dart';

class AppUser {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String image;
  final String? token;
  final Gender gender;

  const AppUser({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.image,
    this.token,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'token': token,
      'gender': gender
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as int,
      username: map['username'] as String,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      image: map['image'] as String,
      gender: Gender.fromString(map['gender']),
    );
  }

  AppUser copyWith({
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? image,
    String? token,
    Gender? gender,
  }) {
    return AppUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      image: image ?? this.image,
      token: token ?? this.token,
      gender: gender ?? this.gender,
    );
  }
}
