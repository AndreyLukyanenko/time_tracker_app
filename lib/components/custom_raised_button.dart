import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final Widget child;
  final double height;

  const CustomRaisedButton({
    Key key,
    this.onPressed,
    this.color,
    this.child,
    this.height: 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: child,
      ),
    );
  }
}
