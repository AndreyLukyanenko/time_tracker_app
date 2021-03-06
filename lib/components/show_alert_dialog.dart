import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
  BuildContext context, {
  @required String title,
  @required String content,
  @required String defaultAcctiontext,
  String cancelActionText,
}) {
  if (!Platform.isIOS) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if (cancelActionText != null)
            FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(cancelActionText)),
          FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(defaultAcctiontext))
        ],
      ),
    );
  }
  return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (cancelActionText != null)
                CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(cancelActionText)),
              CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(defaultAcctiontext))
            ],
          ));
}
