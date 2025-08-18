import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.hintText});
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.textFieldBackground,
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
