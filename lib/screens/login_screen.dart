import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_screen.dart';

import '../utilities/button_welcome_page.dart';
import '../utilities/inputField_login_signup.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Flexible(
                  child: Hero(
                    tag: 'dash',
                    child:
                        // logo
                        CircleAvatar(
                      foregroundImage: AssetImage('images/logo.png'),
                      radius: 100,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                LoginAndSignupInput(
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  icon: FontAwesomeIcons.envelope,
                  hinttext: 'Enter your email',
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginAndSignupInput(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  icon: FontAwesomeIcons.lock,
                  hinttext: 'Enter your password',
                ),
                const SizedBox(
                  height: 30,
                ),
                HomeScreenButtons(
                  buttonLabel: 'Login',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      // ignore: unused_local_variable
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        showSpinner = true;
                      });
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
