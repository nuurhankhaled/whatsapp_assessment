import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/routing/router.dart';
import 'package:whatsapp_assessment/core/theme/app_theme.dart';
import 'package:whatsapp_assessment/generated/translations/locale_keys.g.dart';

class WhatsAppApp extends StatelessWidget {
  WhatsAppApp({super.key});

  final appRouter = RootRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: tr(LocaleKeys.app_name),
      builder: (context, child) {
        return MediaQuery.withNoTextScaling(child: child ?? const SizedBox());
      },
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      onGenerateTitle: (_) => tr(LocaleKeys.app_name),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: AutoRouterDelegate(appRouter),
      theme: AppTheme.instance.lightTheme,
    );
  }
}
