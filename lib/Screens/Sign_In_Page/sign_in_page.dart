import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/Screens/Sign_In_Page/email_sign_in_page.dart';
import 'package:time_tracker/components/show_alert_dialogue.dart';
import 'package:time_tracker/components/sign_in_button.dart';
import 'package:time_tracker/components/social_sign_in_button.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABBORTED_BY_USER') {
      return;
    } else {
      showExeptionAlertDialogue(
        context,
        title: 'Sign in Failed',
        exception: exception,
      );
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      setState(() => _isLoading = true);
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      setState(() => _isLoading = true);
      await auth.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      setState(() => _isLoading = true);
      await auth.signInAnonymously();
      setState(() => _isLoading = false);
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
          ),
          SizedBox(height: 48.0),
          SocialSignInButton(
            text: 'Sign up with Google',
            assetName: 'images/google-logo.png',
            onPressed: () => _isLoading ? null : _signInWithGoogle(context),
            color: Colors.white,
            textColor: Colors.black87,
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign up with Facebook',
            onPressed: () => _isLoading ? null : _signInWithFacebook(context),
            color: Color(0xFF334D92),
            textColor: Colors.white,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign up with Email',
            onPressed: () => _isLoading ? null : _signInWithEmail(context),
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
            onPressed: () => _isLoading ? null : _signInAnonymously(context),
            color: Color(0xFFf2d675),
            textColor: Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
