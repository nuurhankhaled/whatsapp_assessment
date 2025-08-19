import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/helpers/spacing.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/updates/presentation/widgets/my_status_widget.dart';
import 'package:whatsapp_assessment/features/updates/presentation/widgets/status_card.dart';
import 'package:whatsapp_assessment/generated/translations/locale_keys.g.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyStatusWidget(),
          verticalSpace(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              tr(LocaleKeys.recenentUpdates),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
          verticalSpace(6),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (context, index) {
              return const StatusCard();
            },
          ),
          verticalSpace(100),
        ],
      ),
    );
  }
}
