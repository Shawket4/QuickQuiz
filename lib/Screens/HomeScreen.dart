import 'package:flutter/material.dart';
import 'package:quick_quiz/Screens/PresentationsScreen.dart';
import 'package:quick_quiz/Screens/QuestionBanksScreen.dart';
import 'package:quick_quiz/Screens/QuizzesScreen.dart';
import 'package:quick_quiz/Screens/VideosScreen.dart';
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
      drawer: Drawer(
        backgroundColor: const Color(0xFF011627),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/images/user_avatar.png"
                      ),
                      radius: 25,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 22,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFDFFFC)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PresentationsScreen()));
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Presentations",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFDFFFC)
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizzesScreen()));
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Quizzes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                          color: Color(0xFFFDFFFC)
                      ),
                    ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const QuestionBanksScreen()));
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Question Banks",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFDFFFC)
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const VideosScreen()));
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Videos",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFDFFFC)
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF011627),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () async {
                 final bool response = await Logout;
                 if (response) {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
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
