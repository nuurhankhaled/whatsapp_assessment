import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class GreyPlusButton extends StatelessWidget {
  const GreyPlusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lightGreyBackground,
      ),
      child: Image.asset(Assets.images.greyPlus.path),
    );
  }
}
