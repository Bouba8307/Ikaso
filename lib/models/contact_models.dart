import 'package:flutter/material.dart';

class ContactModel {
  String id;
  String nom;
  String prenom;
  String nomComplet;
  String tel;
  MemoryImage? displayImage;

  ContactModel({
    this.id = '',
    this.nom = '',
    this.prenom = '',
    this.nomComplet = '',
    this.tel = '',
    this.displayImage,
  });

  String getNomCompletOfUser() {
    return nomComplet = '${nom.trim()} ${prenom.trim()}';
  }
}