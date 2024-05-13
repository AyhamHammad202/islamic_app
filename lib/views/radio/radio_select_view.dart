import 'package:flutter/material.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/constants/constant.dart';
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
        body: ListView.builder(
          itemCount: Constant.radioLinks.length,
          itemBuilder: (context, index) {
            return RadioChannel(index: index);
          },
        ),
      ),
    );
  }
}
