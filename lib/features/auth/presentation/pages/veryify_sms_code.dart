import 'package:flutter/material.dart';
import 'package:auth_test55/shared/size_config.dart';


class VeryifySmsCode extends StatelessWidget {
  const VeryifySmsCode({super.key});



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(16)),
            ),
          ),
        ),
      ),
    );
  }
}
