import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/cache_helper/cache_helper.dart';
import 'package:whatsapp_assessment/core/cache_helper/cache_values.dart';
import 'package:whatsapp_assessment/core/routing/router.dart';
import 'package:whatsapp_assessment/core/theme/app_theme.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';
import 'package:whatsapp_assessment/generated/translations/locale_keys.g.dart';

class WhatsAppApp extends StatelessWidget {
  WhatsAppApp({super.key});
  bool isdark = CacheHelper.getData(key: CacheKeys.isDark) as bool? ?? false;

  final appRouter = RootRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeThemeCubit()..changeTheme(fromShared: isdark),
      child: BlocConsumer<ChangeThemeCubit, ChangeThemeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = context.read<ChangeThemeCubit>();

          return MaterialApp.router(
            title: tr(LocaleKeys.app_name),
            builder: (context, child) {
              return MediaQuery.withNoTextScaling(
                child: child ?? const SizedBox(),
              );
            },
            debugShowCheckedModeBanner: false,
            locale: context.locale,
            onGenerateTitle: (_) => tr(LocaleKeys.app_name),
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            routeInformationParser: appRouter.defaultRouteParser(),
            routerDelegate: AutoRouterDelegate(appRouter),
            theme: AppTheme.instance.lightTheme,
            darkTheme: AppTheme.instance.darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
