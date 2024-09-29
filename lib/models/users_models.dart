import 'package:flutter/material.dart';

class UsersModel {
  String id;
  String email;
  String password;
  String nom;
  String prenom;
  String city;
  String country;
  String bio;
  bool isHost;
  List<String> myPostingIDs;
  List<String> savedPostingIDs;
  double earnings;
  String phoneNumber;
  String profileImageUrl;
  ImageProvider? displayImage;

  UsersModel({
    required this.id,
    required this.email,
    required this.password,
    required this.nom,
    required this.prenom,
    required this.city,
    required this.country,
    required this.bio,
    this.isHost = false,
    this.myPostingIDs = const [],
    this.savedPostingIDs = const [],
    this.earnings = 0.0,
    required this.phoneNumber,
    required this.profileImageUrl,
    this.displayImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'nom': nom,
      'prenom': prenom,
      'city': city,
      'country': country,
      'bio': bio,
      'isHost': isHost,
      'myPostingIDs': myPostingIDs,
      'savedPostingIDs': savedPostingIDs,
      'earnings': earnings,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
    };
  }

  static UsersModel fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      nom: map['nom'],
      prenom: map['prenom'],
      city: map['city'],
      country: map['country'],
      bio: map['bio'],
      isHost: map['isHost'] ?? false,
      myPostingIDs: List<String>.from(map['myPostingIDs'] ?? []),
      savedPostingIDs: List<String>.from(map['savedPostingIDs'] ?? []),
      earnings: map['earnings'] ?? 0.0,
      phoneNumber: map['phoneNumber'],
      profileImageUrl: map['profileImageUrl'],
    );
  }
}