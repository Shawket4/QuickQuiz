import 'package:flutter/material.dart';


class PresentationsScreen extends StatefulWidget {
  const PresentationsScreen({Key? key}) : super(key: key);

  @override
  State<PresentationsScreen> createState() => _PresentationsScreenState();
}

class _PresentationsScreenState extends State<PresentationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF011627),
        title: const Text(
          "Presentations",
        ),
      ),
      body: const Center(
        child: Text(
            "Presentations"
        ),
      ),
    );
  }
}
