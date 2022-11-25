import 'package:flutter/material.dart';

class QuestionBanksScreen extends StatefulWidget {
  const QuestionBanksScreen({Key? key}) : super(key: key);

  @override
  State<QuestionBanksScreen> createState() => _QuestionBanksScreenState();
}

class _QuestionBanksScreenState extends State<QuestionBanksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF011627),
        title: const Text(
          "Question Banks",
        ),
      ),
      body: const Center(
        child: Text(
            "Question Banks"
        ),
      ),
    );
  }
}
