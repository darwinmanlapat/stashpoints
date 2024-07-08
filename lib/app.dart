import 'package:flutter/material.dart';

class Stasher extends StatelessWidget {
  const Stasher({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
    );
  }
}
