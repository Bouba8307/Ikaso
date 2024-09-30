import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ikaso/view/accueil_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 243, 235, 163),
              Color.fromARGB(255, 238, 187, 110)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/logop.svg"),
            // Image.asset('assets/images/logo.jpg'), // Logo Ikaso
            const SizedBox(height: 20),
            const Text(
              "Bienvenue sur",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers les pages de chargement
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoadingScreens()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade700,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'COMMENCER',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
