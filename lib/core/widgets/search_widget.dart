import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.hintText});
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: context.read<ChangeThemeCubit>().isDark
            ? Colors.grey.shade900.withAlpha(170)
            : AppColors.lightGreyBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.textSecondary,
            fontSize: 16.5,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 1.0),
            child: Image.asset(Assets.images.searchIcon.path),
          ),
          prefixIconConstraints: const BoxConstraints(maxWidth: 30),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 13.5),
        ),
      ),
    );
  }
}
