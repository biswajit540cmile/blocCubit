import 'package:bloccubit/view/view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bloc_Cubit',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: Center(
        child: MaterialButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const PostsPage(),)); },
        child: Text("Click Me"),
        ),
      ),
    );
  }
}
