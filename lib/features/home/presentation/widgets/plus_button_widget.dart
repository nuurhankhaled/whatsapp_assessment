import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeThemeCubit, ChangeThemeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          width: 28,
          height: 28,
          padding: const EdgeInsets.all(2.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.tealColor,
          ),
          child: Image.asset(
            Assets.images.plusIcon.path,
            color: context.read<ChangeThemeCubit>().isDark
                ? Colors.black
                : Colors.white,
          ),
        );
      },
    );
  }
}
