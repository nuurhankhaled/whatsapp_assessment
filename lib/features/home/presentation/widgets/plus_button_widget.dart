import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      padding: const EdgeInsets.all(2.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.tealColor,
      ),
      child: Image.asset(Assets.images.plusIcon.path),
    );
  }
}
