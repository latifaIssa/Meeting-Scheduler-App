import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/helpers/db_helper.dart';
import 'package:meeting_scheduler_app/routing/router.dart';
import 'package:meeting_scheduler_app/ui/layout/narrow_layout.dart';
import 'package:meeting_scheduler_app/ui/layout/wide_layout.dart';
import 'package:meeting_scheduler_app/ui/screens/splash_screen.dart';

import 'helpers/sharedprefernces_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //when exist onther code to execute
  await SpHelper.spHelper.initSharedPrefernces();

  //Initialize library
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  runApp(
    MyApp(),
    // EasyLocalization(
    //   supportedLocales: [Locale('en'), Locale('ar')],
    //   path: 'assets/langs',
    //   fallbackLocale: Locale('en'),
    //   child: MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppRouter.router.navKey,
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
      home: SplashScreen(),
      // },
    );
  }
}
