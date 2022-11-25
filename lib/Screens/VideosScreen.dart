import 'package:flutter/material.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF011627),
        title: const Text(
          "Videos",
        ),
      ),
      body: const Center(
        child: Text(
            "Videos"
        ),
      ),
    );
  }
}
