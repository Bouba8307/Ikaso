import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ikaso/view_models/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  File? _imageFile;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Créer un nouveau compte"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 243, 235, 163),
                Color.fromARGB(255, 238, 187, 110),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 243, 235, 163),
              Color.fromARGB(255, 238, 187, 110),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Image.asset("assets/images/logo.png", width: 240),
            const Text(
              "À propos de toi",
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextFormField("Email", _emailController, Icons.email,
                      TextInputType.emailAddress),
                  _buildPasswordField(),
                  _buildTextFormField(
                      "Prénom", _firstNameController, Icons.person),
                  _buildTextFormField(
                      "Nom", _lastNameController, Icons.person_outline),
                  _buildTextFormField("Numéro de téléphone", _phoneController,
                      Icons.phone, TextInputType.phone),
                  _buildTextFormField(
                      "Ville", _cityController, Icons.location_city),
                  _buildTextFormField("Pays", _countryController, Icons.flag),
                  _buildTextFormField("Bio", _bioController, Icons.info,
                      TextInputType.multiline, false, 3),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            _buildImagePicker(),
            ElevatedButton(
              onPressed: _onSignUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Créer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String label, TextEditingController controller, IconData icon,
      [TextInputType type = TextInputType.text,
      bool obscureText = false,
      int maxLines = 1]) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
        controller: controller,
        keyboardType: type,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return "Veuillez entrer $label.";
          }
          if (label == "Email" && !GetUtils.isEmail(text)) {
            return "Veuillez entrer un email valide.";
          }
          if (label == "Numéro de téléphone" && !GetUtils.isPhoneNumber(text)) {
            return "Veuillez entrer un numéro de téléphone valide.";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          labelText: "Mot de passe",
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        controller: _passwordController,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return "Veuillez entrer un mot de passe.";
          }
          if (text.length < 6) {
            return "Le mot de passe doit contenir au moins 6 caractères.";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildImagePicker() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: () async {
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            setState(() {
              _imageFile = File(pickedFile.path);
            });
          }
        },
        child: _imageFile == null
            ? const Icon(Icons.add_a_photo)
            : CircleAvatar(radius: 50, backgroundImage: FileImage(_imageFile!)),
      ),
    );
  }

  void _onSignUp() async {
  if (_imageFile == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Veuillez choisir une image.")),
    );
    return;
  }
  if (_formKey.currentState!.validate()) {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );
      
      await UserViewModel().signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _lastNameController.text.trim(),
        _firstNameController.text.trim(),
        _cityController.text.trim(),
        _countryController.text.trim(),
        _bioController.text.trim(),
        _phoneController.text.trim(),
        _imageFile!,
      );
      
      Navigator.of(context).pop(); // Ferme le dialogue de chargement
      Navigator.of(context).pushReplacementNamed('/home'); // Navigue vers la page d'accueil
    } catch (e) {
      Navigator.of(context).pop(); // Ferme le dialogue de chargement
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Veuillez remplir tous les champs correctement.")),
    );
  }
}}