import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

// ignore: must_be_immutable
class ThemeToggleWidget extends StatelessWidget {
  ThemeToggleWidget({super.key});

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeThemeCubit, ChangeThemeStates>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<ChangeThemeCubit>().changeTheme();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: AssetImage(
                  context.read<ChangeThemeCubit>().isDark
                      ? Assets.images.dark.path
                      : Assets.images.light.path,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment: context.read<ChangeThemeCubit>().isDark
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withAlpha(51),
                          blurRadius: 10,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
