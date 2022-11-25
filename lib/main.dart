import 'package:flutter/material.dart';
import 'package:quick_quiz/Screens/HomeScreen.dart';
import 'package:quick_quiz/Screens/login_page.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

const String ServerIP = "http://192.168.1.9:6666";

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
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _getJwt,
          builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        } else {
          if (jwt.isNotEmpty) {
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
