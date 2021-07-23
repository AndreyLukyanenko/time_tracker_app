import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/components/show_alert_dialog.dart';

Future<void> showExeptionAlertDialogue(
  BuildContext context, {
  @required String title,
  @required Exception exception,
}) =>
    showAlertDialog(
      context,
      title: title,
      content: _message(exception),
      defaultAcctiontext: 'Ok',
    );

String _message(Exception exception) {
  return exception is FirebaseException
      ? exception.message
      : exception.toString();
}
