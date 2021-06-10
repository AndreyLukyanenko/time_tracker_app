import 'package:flutter/material.dart';
import 'package:time_tracker/components/show_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: "Are your shure you want to logout? ",
      cancelActionText: 'Cancel',
      defaultAcctiontext: 'Logout',
    );
    if (didRequestSignOut == true) {
      _signOut();
    }
  }

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
