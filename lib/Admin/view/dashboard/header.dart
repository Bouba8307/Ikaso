import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Recherche
        const Expanded(child: SearchField()),

        // Espacement entre la recherche et les icônes
        const SizedBox(width: 16),

        // Icône de messages
        IconButton(
          icon: SvgPicture.asset(
            "icons/message.svg",
            height: 24,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),

        // Icône de notification
        IconButton(
          icon: SvgPicture.asset(
            "icons/notification.svg",
            height: 24,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),

        // Carte du profil
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Row(
        children: [
          // Image de profil ronde
          CircleAvatar(
            backgroundImage: AssetImage("images/avatar.jpg"),
            radius: 16,
          ),
          SizedBox(width: 8),
          Text(
            "Bouba",
            style: TextStyle(color: Colors.black87),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Type to search",
        fillColor: const Color.fromARGB(255, 245, 245, 245),
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {
            // Logique pour la recherche
          },
          child: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: const BoxDecoration(
              color: Color(0xFF2697FF),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("icons/search.svg"),
          ),
        ),
      ),
    );
  }
}
