
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/presentation/providers/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MaterialButton(
          onPressed: (){
            Provider.of<AuthProvider>(context, listen: false).signOut();
          },
          child: Text("Sign out"),
        ),
      ),
    );
  }
}
