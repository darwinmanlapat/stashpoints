import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stashpoints/app.dart';
import 'package:stashpoints/common/configs/env_config.dart';
import 'package:stashpoints/common/services/http_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvConfig.initialize();

  runApp(
    Provider(
      create: (_) => HttpService(),
      child: const Stasher(),
    ),
  );
}
