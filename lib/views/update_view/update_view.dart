import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/quran_controller.dart';

class UpdateView extends StatelessWidget {
  const UpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();

    return BackgroundImage(
      child: Obx(() {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: quranController.isUpdateCompluted.isFalse
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                        "تم تحميل التحديث يرجى اغلاق التطبيق ثم فتحه مره اخرى"),
                    IconButton(
                        onPressed: () async {
                          exit(0);
                        },
                        icon: const Icon(CupertinoIcons.restart))
                  ],
                ),
        );
      }),
    );
  }
}
