import 'package:flutter/material.dart';
import 'package:time_tracker/Screens/Home_Page/home_page.dart';
import 'package:time_tracker/Screens/Sign_In_Page/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker/services/auth.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_user == null)
        ? SignInPage(
            auth: widget.auth,
            onSignIn: _updateUser,
          )
        : HomePage(
            auth: widget.auth,
            onSignOut: () => _updateUser(null),
          ); //Placeholder for Home Page;
  }
}
