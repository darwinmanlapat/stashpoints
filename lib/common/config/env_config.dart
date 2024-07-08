import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> initialize() async {
    await dotenv.load();
    final envKeys = dotenv.env.keys.toList();

    if (!dotenv.isEveryDefined(envKeys)) {
      throw AssertionError('$envKeys must be defined in the .env file');
    }
  }

  static String get environment => dotenv.env['REST_ENDPOINT']!;
}
