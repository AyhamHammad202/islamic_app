import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/radio_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/views/radio/widgets/radio_channel.dart';

class RadioSelectView extends StatelessWidget {
  const RadioSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(S.current.radio),
        ),
        body: GetBuilder<RadioController>(builder: (radioController) {
          return GridView.builder(
            itemCount: radioController.radioes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return RadioChannel(
                radioModel: radioController.radioes[index],
              );
            },
          );
        }),
      ),
    );
  }
}
