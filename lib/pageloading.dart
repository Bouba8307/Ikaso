import 'dart:async';
import 'package:flutter/material.dart';

class PageLoading extends StatefulWidget {
  const PageLoading({super.key});

  @override
  _PageLoadingState createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Liste des pages à afficher
  final List<Widget> _pages = [
    _buildPageContent(
      imagePath: 'images/one.jpg',
      title: "Réservation d'hébergement n'importe où",
      description: "Plus facile",
    ),
    _buildPageContent(
      imagePath: 'images/two.jpg',
      title: "Planifiez vos vacances avec Ikaso",
      description: "",
    ),
    _buildPageContent(
      imagePath: 'images/third.png',
      title: "Des milliers d'hébergements à venir",
      description: "Trouvé",
    ),
  ];

  static Widget _buildPageContent({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blueAccent,
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Se connecter'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Continue sans compte'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startPageTransition();
  }

  void _startPageTransition() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        _currentPage =
            (_currentPage + 1) % _pages.length; // Boucle à travers les pages
      });

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Désactiver le défilement manuel
        children: _pages,
      ),
    );
  }
}
