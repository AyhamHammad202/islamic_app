import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/azkar_controller.dart';

class AzkarView extends StatefulWidget {
  const AzkarView({super.key});

  @override
  State<AzkarView> createState() => _AzkarViewState();
}

class _AzkarViewState extends State<AzkarView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AzkarController azkarController = Get.put(AzkarController());
    azkarController.getAllTheAzkar();
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY NAME IS AYHAM"),
        actions: [
          IconButton(
              onPressed: () {
                azkarController.resetAllAzkar().then(
                      (value) => Get.showSnackbar(
                        const GetSnackBar(
                          message:
                              "تم أستعادة جميع الاذكار الى حالتها الافتراضية",
                          duration: Duration(seconds: 1),
                        ),
                      ),
                    );
              },
              icon: const Icon(Icons.lock_reset))
        ],
      ),
      body: GetBuilder<AzkarController>(builder: (controller) {
        return ListView.builder(
          itemCount: azkarController.azkar.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _controller.text = azkarController.azkar[index].zekr;
                Scaffold.of(context).showBottomSheet((context) => Container(
                      child: Column(
                        children: [
                          TextField(
                            controller: _controller,
                            onSubmitted: (value) {
                              azkarController.updateZekr(
                                  value, azkarController.azkar[index]);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ));
              },
              onLongPress: () {
                azkarController.deleteZekr(azkarController.azkar[index]).then(
                      (value) => Get.showSnackbar(
                        const GetSnackBar(
                          message: "تم حذف الذكر",
                          duration: Duration(seconds: 1),
                        ),
                      ),
                    );
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                color: kThirdlyColor.withOpacity(0.7),
                child: Column(
                  children: [
                    Text(azkarController.azkar[index].id.toString()),
                    Text(azkarController.azkar[index].zekr),
                    IconButton(
                        onPressed: () {
                          azkarController
                              .resetOneZekr(azkarController.azkar[index])
                              .then(
                                (value) => Get.showSnackbar(
                                  const GetSnackBar(
                                    message:
                                        "تم أستعادة الذكر الى حالته الافتراضية",
                                    duration: Duration(seconds: 1),
                                  ),
                                ),
                              );
                        },
                        icon: const Icon(Icons.lock_reset))
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
