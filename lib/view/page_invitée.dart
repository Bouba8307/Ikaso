import 'package:flutter/material.dart';
import 'package:ikaso/view/pages_bottom_bar/compte.dart';
import 'package:ikaso/view/pages_bottom_bar/explore_screen.dart';
import 'package:ikaso/view/pages_bottom_bar/favories.dart';
import 'package:ikaso/view/pages_bottom_bar/message.dart';
import 'package:ikaso/view/pages_bottom_bar/reservation.dart';

class PageInvite extends StatefulWidget {
  const PageInvite({super.key});

  @override
  State<PageInvite> createState() => _PageInviteState();
}

class _PageInviteState extends State<PageInvite> {
  int selectedIndex = 0;
  final List<String> screenTitles = [
    'Explorer',
    'Favories',
    'Réservé',
    'Message',
    'Profile'
  ];

  final List<Widget> screens = [
    ExploreScreen(),
    favoriesScreen(),
    ReservationScreen(),
    MessageScreen(),
    AccountScreen(),
  ];

  BottomNavigationBarItem customNavigationBarItem(int index, IconData iconData, String title) 
  {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: Colors.black,
      ),
      activeIcon: Icon(
        iconData,
        color: Color(0xFFF3C63F),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          setState(() {
            selectedIndex = i;
          });
        },
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
        
        customNavigationBarItem(0, Icons.explore, screenTitles[0]),
        customNavigationBarItem(1, Icons.favorite, screenTitles[1]),
        customNavigationBarItem(2, Icons.calendar_month, screenTitles[2]),
        customNavigationBarItem(3, Icons.message, screenTitles[3]),
        customNavigationBarItem(4, Icons.person, screenTitles[4]),
    ]
    )
    );
  }
}
