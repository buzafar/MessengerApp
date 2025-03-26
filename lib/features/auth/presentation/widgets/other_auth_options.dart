import 'package:auth_test55/features/auth/presentation/pages/verify_phone_number.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auth_test55/shared/size_config.dart';
import '../providers/auth_provider.dart';
import 'package:auth_test55/shared/size_config.dart';
import '../pages/verify_phone_number.dart';

class OtherAuthOptions extends StatefulWidget {
  const OtherAuthOptions(this.authProvider, {super.key});

  final AuthProvider authProvider;

  @override
  State<OtherAuthOptions> createState() => _OtherAuthOptionsState();
}

class _OtherAuthOptionsState extends State<OtherAuthOptions> {
  Future _googleSignIn() async {
    await widget.authProvider.signInWithGoogle();
  }

  Future _sendToPhonePage(BuildContext context) async {
    Navigator.push(context,
      MaterialPageRoute(builder: (_) => VerifyPhoneNumber(widget.authProvider)))
    ;
  }

  Future _facebookSignIn() async {
    await widget.authProvider.signInWithFacebook();
    
    final errorText = widget.authProvider.errorText;
    if (errorText != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorText), behavior: SnackBarBehavior.floating,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _googleSignIn,
            icon: SvgPicture.asset(
              "assets/google.svg",
              width: SizeConfig.w(15),
            ),
            label: const Text(
              "Continue with Google",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),


        // SizedBox(
        //   width: double.infinity,
        //   child: OutlinedButton.icon(
        //     onPressed: () {
        //       _sendToPhonePage(context);
        //     },
        //     icon: SvgPicture.asset(
        //       "assets/phone_number.svg",
        //       width: SizeConfig.w(15),
        //     ),
        //     label: const Text(
        //       "Continue with Phone Number",
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   width: double.infinity,
        //   child: OutlinedButton.icon(
        //     onPressed: _facebookSignIn,
        //     icon: SvgPicture.asset(
        //       "assets/facebook.svg",
        //       width: SizeConfig.w(15),
        //     ),
        //     label: const Text(
        //       "Continue with Facebook",
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   width: double.infinity,
        //   child: OutlinedButton.icon(
        //     onPressed: () {},
        //     icon: SvgPicture.asset(
        //       "assets/apple.svg",
        //       width: SizeConfig.w(15),
        //     ),
        //     label: const Text(
        //       "Continue with Apple",
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
