// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

import '../utilities/button_welcome_page.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'dash',
              child:
                  // logo
                  Container(
                child: const CircleAvatar(
                  backgroundImage: AssetImage('images/logo.png'),
                  radius: 100,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            HomeScreenButtons(
              buttonLabel: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            HomeScreenButtons(
              buttonLabel: 'Sign up',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
