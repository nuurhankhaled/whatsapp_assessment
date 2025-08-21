import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.read<ChangeThemeCubit>().isDark
            ? Colors.grey.shade900.withAlpha(170)
            : AppColors.iconBackground,
      ),
      child: Image.asset(
        Assets.images.menuIconpng.path,
        color: context.read<ChangeThemeCubit>().isDark
            ? Colors.white
            : Colors.black,
      ),
    );
  }
}
