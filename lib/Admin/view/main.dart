import 'package:flutter/material.dart';
import 'package:ikaso/Admin/view/components/side_menu.dart';
import 'package:ikaso/Admin/view/dashboard/dashboard.dart';
import 'package:ikaso/Admin/view/components/transactions.dart';
import 'package:ikaso/Admin/view/components/Approbations.dart';
import 'package:ikaso/Admin/view/components/Clients.dart';
import 'package:ikaso/Admin/view/components/Reservations.dart';
import 'package:ikaso/Admin/view/components/Utilisateurs.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // Variable pour suivre la page actuellement sélectionnée
  int selectedIndex = 0;

  // Liste des pages disponibles
  final List<Widget> pages = [
    DashboardView(),
    const TransactionsPage(),
    const ApprobationsPage(),
    const ClientPage(),
    const UtilisateursPage(),
    const ReservationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu latéral
            Expanded(
              child: SideMenu(
                selectedIndex: selectedIndex,
                onItemSelected: (index) {
                  setState(() {
                    selectedIndex = index; // Met à jour la page sélectionnée
                  });
                },
              ),
            ),
            // Contenu principal
            Expanded(
              flex: 5,
              child: pages[selectedIndex], // Affiche la page sélectionnée
            ),
          ],
        ),
      ),
    );
  }
}
