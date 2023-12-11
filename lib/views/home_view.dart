import 'package:flutter/material.dart';
import 'package:islamic_app/views/widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String id = "home-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              Text("Last Readed"),
            ],
          ),
        ),
      ),
    );
  }
}
