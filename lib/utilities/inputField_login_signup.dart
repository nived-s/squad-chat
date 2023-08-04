// ignore: file_names
import 'package:flutter/material.dart';

import 'constants.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class LoginAndSignupInput extends StatelessWidget {
  const LoginAndSignupInput(
      {super.key,
      required this.onChanged,
      this.icon,
      this.controller,
      required this.hinttext});

  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final IconData? icon;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: kInputStyles,
        decoration: InputDecoration(
          filled: true,
          fillColor: lightyellowishLogo,
          prefixIcon: Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: FaIcon(
              icon,
              color: orangishLogo,
            ),
          ),
          hintText: hinttext,
          hintStyle: const TextStyle(color: orangishLogo),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide.none,
          ),
        ),
        cursorColor: darkestYellow,
      ),
    );
  }
}
