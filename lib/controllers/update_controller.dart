import 'dart:developer';

import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

class UpdateController extends GetxController {
  late AppUpdateInfo _appUpdateInfo;

  @override
  onInit() async {
    await checkForUpdates();
    log(_appUpdateInfo.packageName);
    super.onInit();
  }

  Future<void> checkForUpdates() async {
    //Checks if there is an update availalbe
    _appUpdateInfo = await InAppUpdate.checkForUpdate();
    if (_appUpdateInfo.updateAvailability ==
        UpdateAvailability.updateAvailable) {
      // if update is available ,start the update
      log("hhhhhhhhhhefgguygew8rct8trc8qb7etr87tc87wrtb8cq");
      await InAppUpdate.startFlexibleUpdate();
    }
  }

  Future<void> completeUpdate() async {
    // Once the update is downloaded, complete the update
    if (_appUpdateInfo.flexibleUpdateAllowed) {
      await InAppUpdate.completeFlexibleUpdate();
    }
  }
}
