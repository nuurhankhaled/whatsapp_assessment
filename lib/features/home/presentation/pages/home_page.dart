import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/functions/pop_curve.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/chats/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:whatsapp_assessment/features/chats/presentation/pages/chats_page.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/main_layout_cubit/main_layout_cubit.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/camera_button.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/floating_action_button_widget.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/menu_button.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/plus_button_widget.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/sliver_app_bar.dart';
import 'package:whatsapp_assessment/features/home/presentation/widgets/tab_bar_config.dart';
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
    _initializeAnimations();
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    _scaleAnimations = _controllers.map((controller) {
      return Tween<double>(
        begin: 1.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: const PopCurve()));
    }).toList();
  }

  void _disposeAnimations() {
    for (final controller in _controllers) {
      controller.dispose();
    }
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

  // App bar configurations for each tab
  Map<int, TabAppBarConfig> get _tabConfigurations => const {
    0: TabAppBarConfig(leftWidget: MenuButton()),
    1: TabAppBarConfig(leftWidget: MenuButton(), rightWidgets: [PlusButton()]),
    2: TabAppBarConfig(rightWidgets: [PlusButton()]),
    3: TabAppBarConfig(
      leftWidget: MenuButton(),
      rightWidgets: [CameraButton(), SizedBox(width: 16), PlusButton()],
    ),
    4: TabAppBarConfig(),
  };

  @override
  Widget build(BuildContext context) {
    // Keep all dynamic content here for theme/locale changes
    final titles = [
      Text(tr(LocaleKeys.updates)),
      Text(tr(LocaleKeys.calls)),
      Text(tr(LocaleKeys.communities)),
      Text(tr(LocaleKeys.chats)),
      Text(tr(LocaleKeys.settings)),
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
            floatingActionButton: (cubit.selectedIndex == 3)
                ? const FloatingActionButtonWidget()
                : null,
            body: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                SystemNavigator.pop();
              },
              child: IndexedStack(
                index: cubit.selectedIndex,
                children: [
                  _buildScaffoldPage(0, titles, context), // Updates
                  _buildScaffoldPage(1, titles, context), // Calls
                  _buildScaffoldPage(2, titles, context), // Communities
                  _buildScaffoldPage(3, titles, context), // Chats
                  _buildScaffoldPage(4, titles, context), // Settings
                ],
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(
              titles,
              unselectedIcons,
              selectedIcons,
              cubit,
            ),
          );
        },
      ),
    );
  }

  Widget _buildScaffoldPage(
    int index,
    List<Text> titles,
    BuildContext context,
  ) {
    final currentConfig = _tabConfigurations[index] ?? const TabAppBarConfig();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            HomeSliverAppBar(
              isCollapsed: innerBoxIsScrolled,
              config: currentConfig,
              titles: titles,
              currentIndex: index,
            ),
          ];
        },
        body: _buildTabContent(index, titles, context, currentConfig),
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    List<Text> appBarTitles,
    List<Widget> unselectedIcons,
    List<Widget> selectedIcons,
    MainLayoutCubit cubit,
  ) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.navBarBorder, width: 0.2),
        ),
      ),
      child: BottomNavigationBar(
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        currentIndex: cubit.selectedIndex,
        backgroundColor: Colors.white.withAlpha(240),
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
        unselectedItemColor: AppColors.textSecondary,
        onTap: (index) {
          _animateIcon(index);
          cubit.changeBottomNavBarIndex(index);
        },
        items: List.generate(5, (index) {
          return BottomNavigationBarItem(
            icon: AnimatedBuilder(
              animation: _scaleAnimations[index],
              builder: (context, child) {
                final progress = _controllers[index].value;
                double scale;

                if (progress <= 0.5) {
                  scale = 1.0 + (progress * 2 * 0.1);
                } else {
                  scale = 1.1 - ((progress - 0.5) * 2 * 0.2);
                }

                scale = scale.clamp(1.0, 1.1);

                return Transform.scale(
                  scale: scale,
                  child: cubit.selectedIndex == index
                      ? selectedIcons[index]
                      : unselectedIcons[index],
                );
              },
            ),
            label: appBarTitles[index].data,
          );
        }),
      ),
    );
  }

  Widget _buildTabContent(
    int index,
    List<Text> appBarTitles,
    BuildContext context,
    TabAppBarConfig config,
  ) {
    switch (index) {
      case 0: // Updates
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appBarTitles[0].data!,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
              ),
              const SizedBox(height: 20),
              Text(
                'Updates content goes here',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
              ),
            ],
          ),
        );
      case 1: // Calls
        return Column(
          children: [
            Center(
              child: Text(
                appBarTitles[1].data!,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontFamily: "SFPro"),
              ),
            ),
          ],
        );
      case 2: // Communities
        return Column(
          children: [
            Center(
              child: Text(
                appBarTitles[2].data!,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontFamily: "SFPro"),
              ),
            ),
          ],
        );
      case 3: // Chats
        return BlocProvider(
          create: (context) => ChatsCubit(),
          child: const ChatsPage(),
        );
      case 4: // Settings
        return Column(
          children: [
            Center(
              child: Text(
                appBarTitles[4].data!,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontFamily: "SFPro"),
              ),
            ),
          ],
        );
      default:
        return const Center(child: Text('Unknown tab'));
    }
  }
}
