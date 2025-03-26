
import 'package:auth_test55/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'password_reset_page.dart';
import 'package:auth_test55/shared/size_config.dart';
import '../widgets/sign_in_forum.dart';
import '../widgets/other_auth_options.dart';
import '../pages/privacy_policy.dart';
import '../pages/terms_of_use.dart';
import 'package:flutter/material.dart';



class AuthPage extends StatefulWidget {
  const AuthPage({required this.signIn, super.key});

  final bool signIn;

  @override
  State<AuthPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<AuthPage> {


  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);

    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height - mediaQuery.padding.top - mediaQuery.padding.bottom;

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      persistentFooterButtons: widget.signIn ? null : [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(style: Theme.of(context).textTheme.bodySmall, children: [
            const TextSpan(text: "By signing up, you agree to our "),
            TextSpan(
                text: "Terms Of Use ",
                style: const TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsOfUse(),
                          fullscreenDialog: true),
                    );
                  }),
            const TextSpan(text: "& "),
            TextSpan(
                text: "Privacy Policy",
                style: const TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy(),
                            fullscreenDialog: true));
                  }),
          ]),
        ),
      ],
      body: SingleChildScrollView(
        child: SafeArea(
              child: SizedBox(
                height: mediaQuery.size.height - mediaQuery.padding.top - mediaQuery.padding.bottom,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(16)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Messenger App", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center,),
                            Text("Easily chat with people from a distance", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
                          ],
                        ),
                      ),

                      Container(
                        // color: Colors.green,
                        // color: Colors.green,
                        constraints: BoxConstraints(
                          minHeight: height * 0.7,
                        ),
                        // color: Colors.green,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    widget.signIn ?
                                    Container(
                                      // color: Colors.red,
                                      height: constraints.minHeight * 0.5,
                                      child: SignInForum(authProvider)
                                    ) :
                                    Container(
                                      // color: Colors.red,
                                        height: constraints.minHeight * 0.5,
                                        child: SignUpForm(authProvider)
                                    ),

                                    const Text("or"),

                                      OtherAuthOptions(authProvider),



                                  ],
                                );
                          }
                        )

                      )

                    ],
                  ),
                ),
              )
        ),
      ),
    );
  }
}

