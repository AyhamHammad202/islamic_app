import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/readers_controller.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/text_themes.dart';

import 'reader_widget.dart';

class Readers extends StatelessWidget {
  const Readers({
    super.key,
    required this.settingsService,
  });

  final SettingsService settingsService;

  @override
  Widget build(BuildContext context) {
    ReadersController readersController = Get.find();
    return Obx(() {
      return PopupMenuButton(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width,
          maxHeight: MediaQuery.sizeOf(context).height * .7,
        ),
        offset: Offset.fromDirection(2),
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
            readersController.readers.length,
            (index) => PopupMenuItem(
              value: index,
              child: ReaderWidget(
                readerModel: readersController.readers[index],
              ),
            ),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Get.locale!.languageCode == 'ar'
                  ? readersController
                      .readers[settingsService.currentReaderIndex.value]
                      .arabicName
                  : readersController
                      .readers[settingsService.currentReaderIndex.value]
                      .englishName,
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
