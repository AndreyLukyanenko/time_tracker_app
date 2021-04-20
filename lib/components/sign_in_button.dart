import 'package:flutter/material.dart';
import 'package:time_tracker/components/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    String text,
    Color color,
    Color textColor,
    Function onPressed,
    Widget child,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15.0,
              color: textColor,
            ),
          ),
          color: color,
          onPressed: onPressed,
        );
}
