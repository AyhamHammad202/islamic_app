import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_library/quran_library.dart';

import '/bindings/bindings.dart';
import '/controllers/quran_controller.dart';
import '/helper.dart';
import '/services/last_read_service.dart';
import '/services/notificiton_service.dart';
import '/services/settings_service.dart';
import '/services/theme_services.dart';
import '/views/home/general_view.dart';
import 'constants/assets.dart';
import 'controllers/general_controller.dart';
import 'generated/l10n.dart';
import 'theme.dart';

void main() async {
  // Initialize Flutter bindings and ensure proper setup
  // تهيئة روابط Flutter والتأكد من الإعداد الصحيح
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(GeneralController());
  await QuranLibrary().init();

  Get.put(QuranController());
  await initalServices();
  await GetStorage.init();
  Get.put(ThemeController());

  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: false,
    ),
  );
}

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
            return c.ayas.isNotEmpty
                ? const GeneralView()
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
