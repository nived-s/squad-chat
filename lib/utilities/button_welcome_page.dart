import 'package:flutter/material.dart';
import 'constants.dart';

class HomeScreenButtons extends StatelessWidget {
  const HomeScreenButtons({super.key, required this.buttonLabel, required this.onPressed});
  final String buttonLabel;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        backgroundColor: yellowishLogo,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      child: Text(
        buttonLabel,
        style: kButtonStyles,
      ),
    );
  }
}
