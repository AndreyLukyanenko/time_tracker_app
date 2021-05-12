import 'package:flutter/material.dart';
import 'package:time_tracker/Screens/Home_Page/home_page.dart';
import 'package:time_tracker/Screens/Sign_In_Page/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    _updateUser(FirebaseAuth.instance.currentUser);
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
            onSignIn: _updateUser,
          )
        : HomePage(
            onSignOut: () => _updateUser(null),
          ); //Placeholder for Home Page;
  }
}
