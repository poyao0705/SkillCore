import 'package:flutter/material.dart';
import 'package:skillcore/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

late Map<String, dynamic> env;

void main() async {
  /// TODO: update Supabase credentials with your own
  WidgetsFlutterBinding.ensureInitialized();
  final envString = await rootBundle.loadString('assets/env.json');
  env = json.decode(envString);
  await Supabase.initialize(
    url: env['SUPABASE_URL'],
    anonKey: env['SUPABASE_ANON_KEY'],
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
