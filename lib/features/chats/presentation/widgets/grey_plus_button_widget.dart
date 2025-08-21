import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class GreyPlusButton extends StatelessWidget {
  const GreyPlusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeThemeCubit, ChangeThemeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          width: 34,
          height: 34,
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.read<ChangeThemeCubit>().isDark
                ? Colors.grey.shade900.withAlpha(170)
                : AppColors.lightGreyBackground,
          ),
          child: Image.asset(Assets.images.greyPlus.path),
        );
      },
    );
  }
}
