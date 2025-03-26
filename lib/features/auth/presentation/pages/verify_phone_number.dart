import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_test55/shared/size_config.dart';
import 'veryify_sms_code.dart';
import 'package:auth_test55/features/auth/presentation/providers/auth_provider.dart' as provider;
import 'package:provider/provider.dart';


class VerifyPhoneNumber extends StatefulWidget {
  VerifyPhoneNumber(this.authProvider, {super.key});

  final provider.AuthProvider authProvider;

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  final TextEditingController _phoneNumberTextEditingController = TextEditingController();

  void _onVerificationCompletedUIFunction() {
  }

  void _onVerificationFailedUIFunction(String error) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(error), behavior: SnackBarBehavior.floating,));
  }

  void _onCodeSentUIFunction() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const VeryifySmsCode()));
  }

  void _onCodeAutoRetrievalTimeoutUIFunction() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Timed out"), behavior: SnackBarBehavior.floating,));
  }

  void _verifyPhoneNumber() async {
    await widget.authProvider.signInWithPhoneNumber(
        phoneNumber: _phoneNumberTextEditingController.text,
        onVerificationCompletedUIFunction: _onVerificationCompletedUIFunction,
        onVerificationFailedUIFunction: _onVerificationFailedUIFunction,
        onCodeSentUIFunction: _onCodeSentUIFunction,
        onCodeAutoRetrievalTimeoutUIFunction: _onCodeAutoRetrievalTimeoutUIFunction
    );
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Enter your Phone Number"),
                  TextField(
                    // keyboardType: TextInputType.number,
                    controller: _phoneNumberTextEditingController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder()
                    ),
                  ),
                  FilledButton(
                    onPressed: _verifyPhoneNumber,
                    child: const Text("Send the code"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





