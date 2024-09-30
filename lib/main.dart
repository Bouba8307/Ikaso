import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ikaso/view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      color: Colors.black54,
      routes: {
        '/loading': (context) =>  LoginScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/logo.jpg'),
            const SizedBox(height: 3),
            ElevatedButton(
              onPressed: () {
                // CircularProgressIndicator();
                Navigator.pushNamed(context, '/loading');
              },
              child: const Text('COMMENCER'),
            ),
          ],
        ),
      ),
    );
  }
}

// class PageLoading extends StatelessWidget {
//   const PageLoading({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Page de Chargement'),
//       ),
//       body: const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
