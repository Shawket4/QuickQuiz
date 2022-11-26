import 'package:flutter/material.dart';
import 'package:quick_quiz/Screens/HomeScreen.dart';
import 'package:quick_quiz/Screens/login_page.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/PresentationsScreen.dart';
import 'Screens/QuestionBanksScreen.dart';
import 'Screens/QuizzesScreen.dart';
import 'Screens/VideosScreen.dart';

void main() {
  runApp(const Router());
}

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late String jwt;
String userName = "";

Future<String> get _getJwt async {
  final SharedPreferences prefs = await _prefs;
  // await prefs.remove("jwt");
  jwt = (prefs.getString('jwt') ?? "");
  dio.options.headers["Cookie"] = "jwt=$jwt";
  try {
    var checkValidity = await dio.get("$ServerIP/ReturnUser");
  } catch (e) {
    Logout;
    jwt = "";
    return jwt;
  }
  return jwt;
}

Future<bool> SetJwt(String jwt) async {
  final SharedPreferences prefs = await _prefs;
  final bool status = await (prefs.setString('jwt', jwt));
  return status;
}
Dio dio = Dio();

Future<String> get GetUserName async {
  var response = await dio.get("$ServerIP/ReturnUser");
  userName = response.data["name"];
  return response.toString();
}

Future<bool> get Logout async {
  final SharedPreferences prefs = await _prefs;
  return await prefs.remove("jwt");
}

const String ServerIP = "http://localhost:6666";

class Router extends StatefulWidget {
  const Router({Key? key}) : super(key: key);
  @override
  State<Router> createState() => _RouterState();
}

class _RouterState extends State<Router> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF0b132b),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _getJwt,
          builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        } else {
          if (jwt != "") {
            return HomeScreen();
          } else {
            return const LoginPage();
          }
        }
      }),
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Quick Quiz',
//       home: LoginPage(),
//     );
//   }
// }
Widget SideMenu(BuildContext context) {
  return Drawer(
    backgroundColor: const Color(0xFF011627),
    child: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4.0, top: 30),
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
                  padding: const EdgeInsets.only(left: 4.0),
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
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5,),
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
  );
}