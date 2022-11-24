import 'package:flutter/material.dart';
import 'package:quick_quiz/Screens/login_page.dart';
import 'package:quick_quiz/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFFFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF011627),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () async {
                 final bool response = await Logout;
                 if (response) {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
                 }
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 30,
                ),
              ),
          ),
        ],
        title: const Text(
          "Home",
        ),
      ),
      body: FutureBuilder(
        future: GetUserName,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Welcome, $userName"),
            );
          }
        },
      ),
    );
  }
}
