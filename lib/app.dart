import 'package:flutter/material.dart';
import 'package:stashpoints/features/stashpoints/presentation/screens/stashpoints_screen.dart';

class Stasher extends StatelessWidget {
  const Stasher({super.key});

  @override
  Widget build(BuildContext context) {
    /*
     * Since the app only has one route, I populated the home parameter
     * with StashpointsScreen. This makes StashpointsScreen the default
     * and only screen that will be displayed when the app is launched.
     */

    return MaterialApp(
      home: const StashpointsScreen(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'DM Sans',
      ),
    );
  }
}
