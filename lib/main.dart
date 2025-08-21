import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_assessment/core/cache_helper/cache_helper.dart';
import 'package:whatsapp_assessment/core/constants/localization.dart';
import 'package:whatsapp_assessment/whatsapp_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  EasyLocalization.logger.enableBuildModes = [];
  runApp(
    EasyLocalization(
      supportedLocales: Localization.instance.supportedLocales,
      path: 'assets/languages',
      startLocale: Localization.instance.enLocale,
      fallbackLocale: Localization.instance.arLocale,
      useOnlyLangCode: true,
      child: WhatsAppApp(),
    ),
  );
}
