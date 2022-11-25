import 'package:flutter/material.dart';
import 'package:quick_quiz/Screens/login_page.dart';
import '../main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController permissionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0b132b),
        title: const Text(
          "Sign up Page",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Quick Quiz',
                  style: TextStyle(
                      // color: Color(0xFF0b132b),
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                autocorrect: false,
                controller: nameController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0b132b),
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Color(0xFF0b132b),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                autocorrect: false,
                controller: usernameController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0b132b),
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                  labelStyle: TextStyle(
                    color: Color(0xFF0b132b),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                autocorrect: false,
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0b132b),
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFF0b132b),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                autocorrect: false,
                controller: permissionController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0b132b),
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Permission',
                  labelStyle: TextStyle(
                    color: Color(0xFF0b132b),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0b132b)),
                child: const Text(
                  "Sign up",
                ),
                onPressed: () async {
                  var response = await dio.post("$ServerIP/RegisterUser/", data: {
                    "name": nameController.text,
                    "email": usernameController.text,
                    "password": passwordController.text,
                    "permission": permissionController.text,
                  });
                  var message = response.data["message"];
                  if (message == "User Created Successfully") {
                    Navigator.of(context)
                        .pop(MaterialPageRoute(builder: (BuildContext context) {
                      return const LoginPage();
                    }));
                  } else if (message == "An Error Has Occured") {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          title: const Text("An Error has occured"),
                          content: const Text("Please fill all fields"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Ok',
                                style: TextStyle(
                                  color: Color(0xFF5bc0be),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("have an account?"),
                TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Color(0xFF5bc0be)),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(MaterialPageRoute(builder: (BuildContext context) {
                      return const LoginPage();
                    }));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
