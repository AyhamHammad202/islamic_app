// ignore_for_file: unused_import

import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:islamic_app/api/firebase_api.dart';
import 'package:islamic_app/bindings/bindings.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/firebase_options.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/services/notificiton_service.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/router.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/services/theme_services.dart';
import 'package:islamic_app/views/home/home_view.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import 'constants/assets.dart';
import 'controllers/audio_controller.dart';
import 'controllers/azkar_controller.dart';
import 'controllers/bookmark_controller.dart';
import 'controllers/general_controller.dart';
import 'generated/l10n.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApi().initNotifictions();
  await initalServices();
  await GetStorage.init();
  Get.put(QuranController());
  Get.put(ThemeController());
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: false,
    ),
  );
  var audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      // Configure your audio service
      androidNotificationChannelId: 'com.mycompany.myapp.audio',
      androidNotificationChannelName: 'Audio Service Demo',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );
  audioHandler.playMediaItem(const MediaItem(id: "1", title: "eeee"));
}

// log('My Prayer Times');
// final myCoordinates = Coordinates(
// 33.380688, 43.652749); // Replace with your own location lat, lng.
// final params = CalculationMethod.umm_al_qura.getParameters();
// params.madhab = Madhab.hanafi;
// final prayerTimes = PrayerTimes.today(myCoordinates, params);

// log("---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
// log(DateFormat.jm().format(prayerTimes.fajr));
// log(DateFormat.jm().format(prayerTimes.sunrise));
// log(DateFormat.jm().format(prayerTimes.dhuhr));
// log(DateFormat.jm().format(prayerTimes.asr));
// log(DateFormat.jm().format(prayerTimes.maghrib));
// log(DateFormat.jm().format(prayerTimes.isha));

// log('---');

Future initalServices() async {
  await Get.putAsync(() => SettingsService().init());
  await Get.putAsync(() => LastReadService().init());
  await Get.putAsync(() => NotificationService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    ThemeController themeController = Get.find();
    SizeConfig().init(context);
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        navigatorKey: navigatorKey,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: themeController.theme,
        // themeMode: ThemeMode.light,
        locale: const Locale("ar"),
        // locale: Get.locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        supportedLocales: S.delegate.supportedLocales,
        // onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
        builder: BotToastInit(), //1. call BotToastInit
        navigatorObservers: [
          BotToastNavigatorObserver()
        ], //2. registered route observer
        // initialRoute: QuranView.id,
        home: GetBuilder<QuranController>(
          init: Get.put(QuranController()),
          builder: (c) {
            return quranController.suarhsInfo.isNotEmpty
                ? const HomeView()
                : Scaffold(
                    body: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SvgPicture.asset(
                        Assets.svgSplash,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
