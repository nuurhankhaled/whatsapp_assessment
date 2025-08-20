import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/helpers/spacing.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/updates/presentation/manager/status_cubit/status_cubit.dart';
import 'package:whatsapp_assessment/features/updates/presentation/widgets/updates_widgets/my_status_widget.dart';
import 'package:whatsapp_assessment/features/updates/presentation/widgets/updates_widgets/status_card.dart';
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
            itemCount: context.read<StatusCubit>().statusList.length,
            itemBuilder: (context, index) {
              return StatusCard(
                model: context.read<StatusCubit>().statusList[index],
                index: index,
              );
            },
          ),
          verticalSpace(100),
        ],
      ),
    );
  }
}
