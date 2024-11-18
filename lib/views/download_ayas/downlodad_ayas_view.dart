import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/controllers/readers_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/reader_model.dart';
import 'package:islamic_app/views/ayat/widgets/reader_widget.dart';
import 'package:islamic_app/views/download_ayas/sura_download_view.dart';

class DownloadAyasView extends StatelessWidget {
  const DownloadAyasView({super.key});

  @override
  Widget build(BuildContext context) {
    AudioController audioController = Get.find();
    QuranController quranController = Get.find();
    ReadersController readersController = Get.find();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            S.current.downloadAyat,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GridView.builder(
            itemCount: readersController.readers.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(
                    () => SuraDownloadView(
                      readerModel: readersController.readers[index],
                    ),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 300),
                  );
                },
                child: ReaderWidget(
                  readerModel: readersController.readers[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
