// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String? password;
  final String name;
  final String? address;
  final String? number;
  String uid;
  final Timestamp createdAt;
  final String profileImage;
  UserModel({
    required this.email,
    this.password,
    required this.name,
    this.address,
    this.number,
    required this.uid,
    required this.createdAt,
    required this.profileImage,
  });

  UserModel copyWith({
    String? email,
    String? password,
    String? name,
    String? address,
    String? number,
    String? uid,
    Timestamp? createdAt,
    String? profileImage,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      address: address ?? this.address,
      number: number ?? this.number,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
      'address': address,
      'number': number,
      'uid': uid,
      'createdAt': createdAt,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      password: map['password'] != null ? map['password'] as String : null,
      name: map['name'] as String,
      address: map['address'] != null ? map['address'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      uid: map['uid'] as String,
      createdAt: map['createdAt'] as Timestamp,
      profileImage: map['profileImage'] as String,
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, password: $password, name: $name, address: $address, number: $number, uid: $uid, createdAt: $createdAt, profileImage: $profileImage)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password &&
      other.name == name &&
      other.address == address &&
      other.number == number &&
      other.uid == uid &&
      other.createdAt == createdAt &&
      other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      password.hashCode ^
      name.hashCode ^
      address.hashCode ^
      number.hashCode ^
      uid.hashCode ^
      createdAt.hashCode ^
      profileImage.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
