import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikaso/models/app_constants.dart';
import 'package:ikaso/models/users_models.dart';
import 'package:ikaso/view/pages_bottom_bar/compte.dart';

class UserViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> signUp(
    String email,
    String password,
    String nom,
    String prenom,
    String ville,
    String pays,
    String bio,
    String phoneNumber,
    File imageFileOfUser,
  ) async {
    try {
      Get.snackbar("Patienter", "Nous mettons en place votre compte");

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String currentUserID = result.user!.uid;

      String imageUrl =
          await addImageToFirebaseStorage(imageFileOfUser, currentUserID);

      UsersModel newUser = UsersModel(
        id: currentUserID,
        email: email,
        password: password,
        nom: nom,
        prenom: prenom,
        city: ville,
        country: pays,
        bio: bio,
        phoneNumber: phoneNumber,
        profileImageUrl: imageUrl,
      );

      await saveUserToFirestore(newUser);

      // Update AppConstants
      AppConstants.currentUser = newUser;
      Get.to(AccountScreen());
      Get.snackbar("Information", "Votre compte a été créé");
    } catch (e) {
      Get.snackbar("Erreur", e.toString());
      rethrow;
    }
  }

  Future<void> saveUserToFirestore(UsersModel user) async {
    Map<String, dynamic> dataMap = {
      "bio": user.bio,
      "ville": user.city,
      "pays": user.country,
      "email": user.email,
      "nom": user.nom,
      "prenom": user.prenom,
      "isHost": user.isHost,
      "myPostingIDs": user.myPostingIDs,
      "savedPostingIDs": user.savedPostingIDs,
      "earnings": user.earnings,
      "phoneNumber": user.phoneNumber,
      "profileImageUrl": user.profileImageUrl,
    };
    await _firestore.collection("users").doc(user.id).set(dataMap);
  }

  Future<String> addImageToFirebaseStorage(
      File imageFileOfUser, String currentUserID) async {
    Reference referenceStorage =
        _storage.ref().child("userImages").child("$currentUserID.png");

    UploadTask uploadTask = referenceStorage.putFile(imageFileOfUser);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  login(BuildContext context, String email, String password) async {
    try {
      print("Début de la tentative de connexion");
      Get.snackbar("Patienter", "Vérification de vos informations en cours");

      UserCredential result =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("Connexion réussie pour l'utilisateur : ${result.user?.uid}");

      String currentUserID = result.user!.uid;
      AppConstants.currentUser.id = currentUserID;

      print("Récupération des informations utilisateur depuis Firestore");
      await getUserInfoFromFirestore(currentUserID);

      print("Récupération de l'image depuis le stockage");
      await getImageFromStorage(currentUserID);

      print("Connexion terminée avec succès");
      Get.snackbar("Connecté", "Connecté avec succès");

      // Utilisez Get.off() au lieu de Navigator.push pour remplacer l'écran actuel
      // Get.off(() => AccountScreen());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AccountScreen()),
      );
    } catch (e) {
      print("Erreur lors de la connexion : $e");
      Get.snackbar("Erreur", e.toString());
    }
  }

  getUserInfoFromFirestore(userID) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").doc(userID).get();

    // Au lieu d'assigner directement le snapshot, extrayez les données
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

    AppConstants.currentUser.nom = userData["nom"] ?? "";
    AppConstants.currentUser.prenom = userData["prenom"] ?? "";
    AppConstants.currentUser.email = userData["email"] ?? "";
    AppConstants.currentUser.city = userData["ville"] ?? "";
    AppConstants.currentUser.country = userData["pays"] ?? "";
    AppConstants.currentUser.phoneNumber = userData["phoneNumber"] ?? "";
    AppConstants.currentUser.bio = userData["bio"] ?? "";
    AppConstants.currentUser.isHost = userData["isHost"] ?? false;
  }

  getImageFromStorage(userID) async {
    if (AppConstants.currentUser.displayImage != null) {
      return AppConstants.currentUser.displayImage;
    }
    final ImageDataBytes = await FirebaseStorage.instance
        .ref()
        .child("userImages")
        .child("userID")
        .child(userID + ".png")
        .getData(1024 * 1024);
    AppConstants.currentUser.displayImage = MemoryImage(ImageDataBytes!);
    return AppConstants.currentUser.displayImage;
  }
}
