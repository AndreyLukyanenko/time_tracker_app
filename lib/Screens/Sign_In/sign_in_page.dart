import 'package:flutter/material.dart';
import 'package:time_tracker/components/sign_in_button.dart';
import 'package:time_tracker/components/custom_raised_button.dart';
import 'package:time_tracker/components/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 48.0),
          SocialSignInButton(
            text: 'Sign up with Google',
            assetName: 'images/google-logo.png',
            onPressed: () {},
            color: Colors.white,
            textColor: Colors.black87,
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign up with Facebook',
            onPressed: () {},
            color: Color(0xFF334D92),
            textColor: Colors.white,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign up with Email',
            onPressed: () {},
            color: Colors.teal[700],
            textColor: Colors.white,
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
          SignInButton(
            text: 'Go anonymous',
            onPressed: () {},
            color: Color(0xFFf2d675),
            textColor: Colors.black87,
          ),
        ],
      ),
    );
  }
}