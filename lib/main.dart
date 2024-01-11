import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/api/firebase_api.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/firebase_options.dart';
import '../../cubits/quran_cubit/quran_cubit.dart';
import 'package:islamic_app/router.dart';
import 'package:islamic_app/views/quran_view.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifictions();
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: false,
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit(),
      child: SafeArea(
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            navigatorKey: navigatorKey,
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
