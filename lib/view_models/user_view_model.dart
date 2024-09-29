import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ikaso/models/app_constants.dart';
import 'package:ikaso/models/users_models.dart';

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

      String imageUrl = await addImageToFirebaseStorage(imageFileOfUser, currentUserID);

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

  Future<String> addImageToFirebaseStorage(File imageFileOfUser, String currentUserID) async {
    Reference referenceStorage = _storage
        .ref()
        .child("userImages")
        .child("$currentUserID.png");

    UploadTask uploadTask = referenceStorage.putFile(imageFileOfUser);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String currentUserID = result.user!.uid;

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection("users")
          .doc(currentUserID)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        AppConstants.currentUser = UsersModel(
          id: currentUserID,
          email: email,
          password: password,
          nom: userData['nom'],
          prenom: userData['prenom'],
          city: userData['ville'],
          country: userData['pays'],
          bio: userData['bio'],
          isHost: userData['isHost'],
          myPostingIDs: List<String>.from(userData['myPostingIDs'] ?? []),
          savedPostingIDs: List<String>.from(userData['savedPostingIDs'] ?? []),
          earnings: (userData['earnings'] ?? 0).toDouble(),
          phoneNumber: userData['phoneNumber'],
          profileImageUrl: userData['profileImageUrl'],
        );
      } else {
        throw Exception("User data not found");
      }
    } catch (e) {
      Get.snackbar("Erreur", e.toString());
      rethrow;
    }
  }
}