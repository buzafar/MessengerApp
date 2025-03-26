
import 'package:auth_test55/features/auth/presentation/pages/privacy_policy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'terms_of_use.dart';
import 'password_reset_page.dart';


class PasswordResetPage extends StatefulWidget {
  PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<PasswordResetPage> {

  final TextEditingController _emailTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    final authProvider = Provider.of<AuthProvider>(context);


    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [

                SizedBox(
                  height: height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Password Reset", style: Theme.of(context).textTheme.titleLarge,),
                      Text("We are going to send a link to your email to reset your password", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
                    ],
                  ),
                ),

                SizedBox(
                  height: height * 0.2,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                       TextField(
                        controller: _emailTextEditingController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            // errorText: _emailErrorText,
                            labelText: "Email",
                            border: OutlineInputBorder()
                        ),
                      ),



                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            authProvider.resetPassword(_emailTextEditingController.text);

                            final errorText = authProvider.errorText;
                            if (errorText != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorText)
                                )
                              );
                            }
                          },

                          child: const Text("SEND RESET LINK TO EMAIL"),
                        ),
                      ),

                      // SizedBox(height: 10,),




                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

