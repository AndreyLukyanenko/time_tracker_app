import 'package:flutter/material.dart';
import 'package:time_tracker/Screens/Sign_In_Page/validators.dart';
import 'package:time_tracker/components/sign_in_button.dart';
import 'package:time_tracker/constans.dart';
import 'package:time_tracker/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  final AuthBase auth;
  EmailSignInForm({Key key, @required this.auth}) : super(key: key);

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailOnEditingcomplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _updateState() {
    setState(() {});
  }

  List<Widget> _buildChildren() {
    const _signInText = 'Sign In';
    const _createAccountText = "Create an account";
    const _registerText = "Register";

    final primaryText = _formType == EmailSignInFormType.signIn
        ? _signInText
        : _createAccountText;

    final secondaryText = _formType == EmailSignInFormType.signIn
        ? "Need an account? $_registerText"
        : "Have an account? $_signInText";

    bool submitEnable = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 16,
      ),
      _buildPasswordTextFeild(),
      SizedBox(
        height: 16,
      ),
      SignInButton(
        text: primaryText,
        textColor: Colors.white,
        color: accentColor,
        onPressed: submitEnable ? _submit : null,
      ),
      SizedBox(
        height: 16,
      ),
      InkWell(
        child: Text(
          secondaryText,
          textAlign: TextAlign.center,
        ),
        onTap: !_isLoading ? toggleFormType : null,
      )
    ];
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
          enabled: _isLoading == false,
          labelText: 'Email',
          hintText: 'Enter your email',
          errorText: showErrorText ? widget.invalidEmailErrorText : null),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailOnEditingcomplete,
    );
  }

  TextField _buildPasswordTextFeild() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
          enabled: _isLoading == false,
          labelText: 'Password',
          hintText: 'Enter your password',
          errorText: showErrorText ? widget.invalidPasswordErrorText : null),
      obscureText: true,
      onChanged: (password) => _updateState,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: _buildChildren(),
        ));
  }
}
