import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/constant.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/main_layout_cubit/main_layout_cubit.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';
import 'package:whatsapp_assessment/generated/translations/locale_keys.g.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    // Create animation controllers for each tab
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    // Create smooth animations that go up and down in one motion
    _scaleAnimations = _controllers.map((controller) {
      return Tween<double>(
        begin: 1.0,
        end: 1.0, // End at the same place it started
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const _PopCurve(), // Custom curve for smooth pop effect
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _animateIcon(int index) {
    try {
      if (_controllers[index].isAnimating) {
        _controllers[index].stop();
      }
      _controllers[index].reset();
      _controllers[index].forward();
    } catch (e) {
      debugPrint('Animation error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitles = [
      Text(tr(LocaleKeys.updates)),
      Text(tr(LocaleKeys.calls)),
      Text(tr(LocaleKeys.communities)),
      Text(tr(LocaleKeys.chats)),
      Text(tr(LocaleKeys.settings)),
    ];
    final screens = [
      Center(
        child: Column(
          children: [
            const SizedBox(height: 505),
            Center(
              child: Text(
                appBarTitles[0].data!,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontFamily: "SFPro"),
              ),
            ),
            Center(child: Text(appBarTitles[0].data!)),
          ],
        ),
      ),
      Center(child: Text(appBarTitles[1].data!)),
      Center(child: Text(appBarTitles[2].data!)),
      Center(child: Text(appBarTitles[3].data!)),
      Center(child: Text(appBarTitles[4].data!)),
    ];

    final unselectedIcons = [
      Image.asset(Assets.images.status.path, width: 32, height: 32),
      Image.asset(Assets.images.calls.path, width: 32, height: 32),
      Image.asset(Assets.images.communities.path, width: 32, height: 32),
      Image.asset(Assets.images.chats.path, width: 32, height: 32),
      Image.asset(Assets.images.settings.path, width: 32, height: 32),
    ];

    final selectedIcons = [
      Image.asset(Assets.images.statusFilled.path, width: 32, height: 32),
      Image.asset(Assets.images.callsFilled.path, width: 32, height: 32),
      Image.asset(Assets.images.communitiesFilled.path, width: 32, height: 32),
      Image.asset(Assets.images.chatsFilled.path, width: 32, height: 32),
      Image.asset(Assets.images.settingsFilled.path, width: 32, height: 32),
    ];

    return BlocProvider(
      create: (context) => MainLayoutCubit(),
      child: BlocConsumer<MainLayoutCubit, MainLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = MainLayoutCubit.get(context);
          return Scaffold(
            extendBody: true,
            body: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, reslut) {
                SystemNavigator.pop();
              },
              child: screens[mainLayoutIntitalScreenIndex],
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.navBarBorder, width: 0.2),
                ),
              ),
              child: BottomNavigationBar(
                selectedFontSize: 12,
                type: BottomNavigationBarType.fixed,
                currentIndex: mainLayoutIntitalScreenIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedLabelStyle: const TextStyle(
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.w300,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.w300,
                ),
                selectedItemColor: Colors.black,
                unselectedItemColor: AppColors.textNavBar,
                onTap: (index) {
                  _animateIcon(index);
                  cubit.changeBottomNavBarIndex(index);
                },
                items: List.generate(5, (index) {
                  return BottomNavigationBarItem(
                    icon: AnimatedBuilder(
                      animation: _scaleAnimations[index],
                      builder: (context, child) {
                        // Calculate the pop scale based on animation progress
                        double progress = _controllers[index].value;
                        double scale;

                        if (progress <= 0.5) {
                          // First half: scale up from 1.0 to 1.2
                          scale = 1.0 + (progress * 2 * 0.2); // 1.0 to 1.2
                        } else {
                          // Second half: scale down from 1.2 to 1.0
                          scale =
                              1.2 - ((progress - 0.5) * 2 * 0.2); // 1.2 to 1.0
                        }

                        scale = scale.clamp(1.0, 1.2); // Safety clamp

                        return Transform.scale(
                          scale: scale,
                          child: mainLayoutIntitalScreenIndex == index
                              ? selectedIcons[index]
                              : unselectedIcons[index],
                        );
                      },
                    ),
                    label: appBarTitles[index].data,
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Custom curve for smooth pop effect
class _PopCurve extends Curve {
  const _PopCurve();

  @override
  double transform(double t) {
    // Smooth curve that goes up and down
    return 4 * t * (1 - t); // Parabolic curve that peaks at t=0.5
  }
}
