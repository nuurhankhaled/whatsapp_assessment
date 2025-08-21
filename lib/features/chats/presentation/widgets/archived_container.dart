import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class ArchivedMessagesContainer extends StatelessWidget {
  const ArchivedMessagesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        spacing: 12.3,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 13),
            width: 56,
            height: 56,
            alignment: Alignment.center,
            child: Image.asset(
              Assets.images.archived.path,
              width: 24,
              height: 24,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ), // Added bottom padding
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: context.read<ChangeThemeCubit>().isDark
                        ? AppColors.darkGreyBackground
                        : AppColors.lightGreyBackground,
                  ),
                ),
              ),
              child: Text(
                'Archived',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
