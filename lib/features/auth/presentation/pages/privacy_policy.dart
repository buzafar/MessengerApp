import 'package:flutter/material.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean convallis neque mauris, et posuere tellus auctor at. "
          ),
        ),
      ),
    );
  }
}
