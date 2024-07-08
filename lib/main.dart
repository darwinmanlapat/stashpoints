import 'package:flutter/material.dart';
import 'package:stashpoints/app.dart';
import 'package:stashpoints/common/config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvConfig.initialize();

  runApp(const Stasher());
}
