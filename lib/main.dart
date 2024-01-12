import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/firebase_options.dart';
import 'package:islamic_app/services/notificiton_service.dart';
import '../../cubits/quran_cubit/quran_cubit.dart';
import 'package:islamic_app/router.dart';
import 'package:islamic_app/views/quran_view.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseApi().initNotifictions();
  await AwesomeNotifications().initialize("resource://drawable/quran", [
    NotificationChannel(
      channelKey: "salatAldoha",
      channelName: "صلاة الضحى",
      channelDescription: "التذكير بصلاة الضحى",
      groupKey: "salatReminder",
      icon: "resource://drawable/quran",
      enableLights: true,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
    NotificationChannel(
      channelKey: "salatAlotr",
      channelName: "صلاة الوتر",
      channelDescription: "التذكير بصلاة الوتر",
      groupKey: "salatReminder",
      icon: "resource://drawable/quran",
      enableLights: true,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    )
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "salatReminder", channelGroupName: "salatGroub")
  ]);
  if (!await AwesomeNotifications().isNotificationAllowed()) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

// This widget is the root of your application.
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit(),
      child: SafeArea(
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            navigatorKey: MyApp.navigatorKey,
            theme: ThemeData(
              scaffoldBackgroundColor: kBackgroundColor,
            ),
            locale: Locale("ar"),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: onGenerateRoute,
            debugShowCheckedModeBanner: false,
            initialRoute: QuranView.id,
          ),
        ),
      ),
    );
  }
}
