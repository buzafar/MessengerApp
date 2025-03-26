import 'package:flutter/material.dart';
import 'my_overlay_circular_progress_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../pages/password_reset_page.dart';
import 'package:flutter/gestures.dart';
import '../pages/auth_page.dart';
import 'package:auth_test55/shared/size_config.dart';


class SignInForum extends StatefulWidget {
  const SignInForum(this.authProvider, {super.key});

  final AuthProvider authProvider;

  @override
  State<SignInForum> createState() => _SignInForumState();
}

class _SignInForumState extends State<SignInForum> {


  final TextEditingController _emailTextEditingController = TextEditingController();

  final TextEditingController _passwordTextEditingController = TextEditingController();

  final FocusNode _emailFieldFocusNode = FocusNode();

  final FocusNode _passwordFieldFocusNode = FocusNode();

  // for errors that occur due to invalid formats even before firebase operations
  String? _emailErrorText;
  String? _passwordErrorText;

  bool _hidePassword = true;

  // late final AuthProvider authProvider;


  @override
  void initState() {
    super.initState();

    // authProvider = Provider.of<AuthProvider>(context);

    _emailFieldFocusNode.addListener(() {
      if (!_emailFieldFocusNode.hasFocus) {
        _validateEmail();
        setState(() {

        });
      }
    });

    _passwordFieldFocusNode.addListener(() {
      if (!_passwordFieldFocusNode.hasFocus) {
        _validatePassword();
        setState(() {
        });
      }
    });

  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();

    _emailFieldFocusNode.dispose();
    _passwordFieldFocusNode.dispose();

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
      FocusScope.of(context).unfocus();
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


  void _signIn() async {
    if (
    (_emailErrorText == null && _passwordErrorText == null) &&
        (_emailTextEditingController.text.isNotEmpty && _passwordTextEditingController.text.isNotEmpty)
    ) {

      final MOCPI = MyOverlayCircularProgressIndicator(context);
      MOCPI.show();
      await widget.authProvider.signIn(_emailTextEditingController.text, _passwordTextEditingController.text);
      MOCPI.close();

      final String? errorText = widget.authProvider.errorText;
      if (errorText != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorText),
              behavior: SnackBarBehavior.floating,
            )
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text("Please complete the form first")
          )
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextField(
          focusNode: _emailFieldFocusNode,
          controller: _emailTextEditingController,
          onEditingComplete: _validateEmail,
          onChanged: _onChangedValidateEmail,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              errorText: _emailErrorText,
              labelText: "Email",
              border: const OutlineInputBorder()
          ),
        ),


        // SizedBox(height: SizeConfig.h(15),),

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
              border: const OutlineInputBorder()
          ),
        ),


        GestureDetector(
          onTap: ()  {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => PasswordResetPage()));
          },
          child: const Align(
              alignment: Alignment.centerRight,
              child: Text("Forgot Password?")
          ),
        ),

        // if (authProvider.isLoading)
        // const CircularProgressIndicator(),


        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _signIn,
            child: const Text("SIGN IN"),
          ),
        ),


        RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.bodySmall,
              children: [
                const TextSpan(text: "Don't have an account? "),
                TextSpan(
                    text: "SIGN UP",
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => AuthPage(signIn: false,))
                        );
                      }
                )
              ]
          ),
        ),
      ],
    );
  }
}
