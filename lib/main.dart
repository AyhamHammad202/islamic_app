// ignore_for_file: unused_import

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/api/firebase_api.dart';
import 'package:islamic_app/bindings/bindings.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/firebase_options.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/services/notificiton_service.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/router.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/views/quran_view.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifictions();
  await initalServices();
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: false,
    ),
  );
}

Future initalServices() async {
  await Get.putAsync(() => NotificationService().init());
  await Get.putAsync(() => LastReadService().init());
  await Get.putAsync(() => SettingsService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
    firebaseAnalytics.logAppOpen();
    SizeConfig().init(context);
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
        ),
        locale: const Locale("ar"),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
        builder: BotToastInit(), //1. call BotToastInit
        navigatorObservers: [
          BotToastNavigatorObserver()
        ], //2. registered route observer
        // initialRoute: QuranView.id,
        home: GetBuilder<QuranController>(
          init: QuranController(),
          builder: (controller) {
            return controller.surahs.isNotEmpty
                ? const QuranView()
                : const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
