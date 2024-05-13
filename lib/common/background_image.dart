import 'package:flutter/material.dart';

import '../constants/assets.dart';
import '../constants/constant.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    // ThemeController themeController = Get.find();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.svgBackground,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            // color: themeController.isDarkMode.value ? Colors.amber : null,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Constant.backgroundImage,
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
            // child: child,
          ),
          child,
        ],
      ),
    );
  }
}
