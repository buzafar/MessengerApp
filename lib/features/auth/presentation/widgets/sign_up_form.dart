import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'my_overlay_circular_progress_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../pages/password_reset_page.dart';
import 'package:flutter/gestures.dart';
import '../pages/privacy_policy.dart';
import '../pages/terms_of_use.dart';
import '../pages/auth_page.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(this.authProvider, {super.key});
  final AuthProvider authProvider;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

  final FocusNode _emailFieldFocusNode = FocusNode();

  final FocusNode _passwordFieldFocusNode = FocusNode();

  final FocusNode _confirmPasswordFieldFocusNode = FocusNode();

  String? _emailErrorText;

  String? _passwordErrorText;

  String? _confirmPasswordErrorText;

  bool _hidePassword = true;

  bool _hideConfirmPassword = true;

  @override
  void initState() {
    super.initState();

    _emailFieldFocusNode.addListener(() {
      if (!_emailFieldFocusNode.hasFocus) {
        _validateEmail();
        setState(() {});
      }
    });

    _passwordFieldFocusNode.addListener(() {
      if (!_passwordFieldFocusNode.hasFocus) {
        _validatePassword();
        setState(() {});
      }
    });

    _confirmPasswordFieldFocusNode.addListener(() {
      if (!_confirmPasswordFieldFocusNode.hasFocus) {
        _validateConfirmPassword();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();

    _emailFieldFocusNode.dispose();
    _passwordFieldFocusNode.dispose();
    _confirmPasswordFieldFocusNode.dispose();

    super.dispose();
  }

  void _validateEmail() {
    String value = _emailTextEditingController.text;
    if (value.isEmpty) {
      _emailErrorText = "Enter your email";
    } else if (!value.endsWith("@gmail.com")) {
      _emailErrorText = "Invalid email";
    } else {
      _emailErrorText = null;
      FocusScope.of(context).requestFocus(_passwordFieldFocusNode);
    }
    setState(() {});
  }

  void _onChangedValidateEmail(String _) {
    String value = _emailTextEditingController.text;
    if (value.isNotEmpty && value.endsWith("@gmail.com")) {
      _emailErrorText = null;
    }
    setState(() {});
  }

  void _validatePassword() {
    String value = _passwordTextEditingController.text;
    if (value.isEmpty) {
      _passwordErrorText = "Enter a password";
    } else if (value.length < 6) {
      _passwordErrorText = "Password must contain at lest 6 characters";
    } else {
      _passwordErrorText = null;
      FocusScope.of(context).requestFocus(_confirmPasswordFieldFocusNode);
    }
    setState(() {});
  }

  void _onChangedValidatePassword(String _) {
    String value = _passwordTextEditingController.text;
    if (value.isNotEmpty && value.length >= 6) {
      _passwordErrorText = null;
    }
    setState(() {});
  }

  void _validateConfirmPassword() {
    String value = _confirmPasswordTextEditingController.text;
    if (value != _passwordTextEditingController.text) {
      _confirmPasswordErrorText = "Passwords are not matching";
    } else {
      _confirmPasswordErrorText = null;
      FocusScope.of(context).unfocus();
    }
    setState(() {});
  }

  void _onChangedValidateConfirmPassword(String _) {
    String value = _confirmPasswordTextEditingController.text;
    if (value != _passwordTextEditingController.text) {
      _confirmPasswordErrorText = null;
    }
    setState(() {});
  }





  Future _signUp() async {
    String? snackBarMessage;

    if ((_emailErrorText == null &&
        _passwordErrorText == null &&
        _confirmPasswordErrorText == null) &&
        (_emailTextEditingController.text.isNotEmpty &&
            _passwordTextEditingController.text.isNotEmpty &&
            _confirmPasswordTextEditingController.text.isNotEmpty)) {

      final overlay = MyOverlayCircularProgressIndicator(context);
      overlay.show();
      await widget.authProvider.signUp(
          _emailTextEditingController.text,
          _passwordTextEditingController.text);
      overlay.close();

      final errorText = widget.authProvider.errorText;
      if (errorText != null) {
        snackBarMessage = errorText;
      }
    } else {
      snackBarMessage = "Please complete the form first";
    }

    if (snackBarMessage != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(snackBarMessage), behavior: SnackBarBehavior.floating,));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      TextField(
        focusNode: _emailFieldFocusNode,
        controller: _emailTextEditingController,
        onEditingComplete: _validateEmail,
        onChanged: _onChangedValidateEmail,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email),
            errorText: _emailErrorText,
            labelText: "Email",
            border: const OutlineInputBorder()),
      ),
      TextField(
        focusNode: _passwordFieldFocusNode,
        controller: _passwordTextEditingController,
        onEditingComplete: _validatePassword,
        onChanged: _onChangedValidatePassword,
        obscureText: _hidePassword,
        obscuringCharacter: "*",
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  _hidePassword = !_hidePassword;
                });
              },
              icon: const Icon(Icons.remove_red_eye),
            ),
            errorText: _passwordErrorText,
            labelText: "Password",
            border: const OutlineInputBorder()),
      ),
      TextField(
        focusNode: _confirmPasswordFieldFocusNode,
        controller: _confirmPasswordTextEditingController,
        onEditingComplete: _validateConfirmPassword,
        onChanged: _onChangedValidateConfirmPassword,
        obscureText: _hideConfirmPassword,
        obscuringCharacter: "*",
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  _hideConfirmPassword = !_hideConfirmPassword;
                });
              },
              icon: const Icon(Icons.remove_red_eye),
            ),
            errorText: _confirmPasswordErrorText,
            labelText: "Confirm Password",
            border: const OutlineInputBorder()),
      ),

      SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _signUp,
            child: const Text("SIGN UP"),
          )),

      RichText(
        text: TextSpan(
            style: Theme.of(context).textTheme.bodySmall,
            children: [
              const TextSpan(text: "Already have an account? "),
              TextSpan(
                  text: "SIGN IN",
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                    Navigator.pop(context);

                    }
              )
            ]
        ),
      ),
    ]);
  }
}
