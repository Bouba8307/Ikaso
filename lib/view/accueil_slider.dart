import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LoadingScreens extends StatelessWidget {
  final List<Map<String, String>> slides = [
    {
      'image': 'assets/images/image2.png',
      'title': 'Réservation d’hébergement n’importe où',
      'subtitle': 'Plus facile',
    },
    {
      'image': 'assets/images/image3.png',
      'title': 'Planifiez vos vacances avec Ikaso',
      'subtitle': '',
    },
    {
      'image': 'assets/images/image4.png',
      'title': 'Des milliers d’hébergements à venir',
      'subtitle': 'Trouvé',
    },
  ];

  LoadingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          height: double.infinity,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enlargeCenterPage:
              false, // Désactiver l'effet d'agrandissement central
          viewportFraction: 1.0,
          enableInfiniteScroll: true,
        ),
        items: slides.map((slide) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Image.asset(
                        slide['image']!,
                        fit: BoxFit.cover, // L'image occupe tout l'espace
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          // Le texte principal
                          Text(
                            slide['title']!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),

                          // Le sous-titre si disponible
                          if (slide['subtitle']!.isNotEmpty)
                            Text(
                              slide['subtitle']!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),

                          const SizedBox(height: 20),

                          // Bouton "Se connecter"
                          ElevatedButton(
                            onPressed: () {
                              // Logique de connexion
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow.shade700,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Se connecter',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Bouton "Continue sans compte"
                          TextButton(
                            onPressed: () {
                              // Logique pour continuer sans compte
                            },
                            child: const Text(
                              'Continue sans compte',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
