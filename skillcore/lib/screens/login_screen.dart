import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skillcore/main.dart';
import 'package:skillcore/screens/profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      }
    });
  }

  Future<AuthResponse?> _googleSignIn() async {
    try {
      final webClientId = env['GOOGLE_WEB_CLIENT_ID'];
      final iosClientId = env['GOOGLE_IOS_CLIENT_ID'];

      final googleSignIn =
          kIsWeb
              ? GoogleSignIn(clientId: webClientId)
              : Platform.isIOS
              ? GoogleSignIn(serverClientId: iosClientId)
              : GoogleSignIn();

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('❌ User canceled Google Sign-In');
        return null;
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        throw Exception('Google Sign-In failed: Missing tokens.');
      }

      debugPrint('✅ Google Sign-In success: $idToken');
      return await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (e, stack) {
      debugPrint('❌ Google Sign-In error: $e');
      debugPrint('🪵 Stack: $stack');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: 
        ElevatedButton(
          onPressed: _googleSignIn,
          child: const Text('Google login'),
        ),
      ),
    );
  }
}
