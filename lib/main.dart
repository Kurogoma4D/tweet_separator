import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';

void main() async {
  await DotEnv().load('assets/.env');
  runApp(App());
}
