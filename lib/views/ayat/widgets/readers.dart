import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/text_themes.dart';

class Readers extends StatelessWidget {
  const Readers({
    super.key,
    required this.settingsService,
  });

  final SettingsService settingsService;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopupMenuButton(
        onSelected: (value) {
          settingsService.currentReaderIndex.value = value;
          settingsService.setReaderIndex(value);
        },
        popUpAnimationStyle: AnimationStyle(
          curve: Curves.easeIn,
          reverseCurve: Curves.easeInOut,
        ),
        color: Theme.of(context).colorScheme.onSurface,
        itemBuilder: (context) {
          return List.generate(
            Constant.readers.length,
            (index) => PopupMenuItem(
              value: index,
              child: Column(
                children: [
                  Text(
                    Constant.readers[index],
                    style: TextThemes.readerTextStyle(context),
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Constant.readers[settingsService.currentReaderIndex.value],
              style: TextThemes.readerTextStyle(context),
            ),
            const Icon(
              Icons.arrow_drop_up_outlined,
              color: Colors.white,
            ),
          ],
        ),
      );
    });
  }
}
