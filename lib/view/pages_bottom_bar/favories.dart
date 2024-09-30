import 'package:flutter/material.dart';

class favoriesScreen extends StatefulWidget {
  const favoriesScreen({super.key});

  @override
  State<favoriesScreen> createState() => _favoriesScreenState();
}

class _favoriesScreenState extends State<favoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favories"),
      ),
    );
  }
}
