import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/functions/date_format.dart';
import 'package:whatsapp_assessment/core/helpers/spacing.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/updates/data/models/status_model.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key, required this.model});
  final StatusModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      height: 67.5,
      child: Row(
        spacing: 12.3,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColors.primaryColor, width: 2),
              shape: BoxShape.circle,
            ),
            width: 56,
            height: 56,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(model.sender.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.lightGreyBackground),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.sender.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    getRelativeTime(model.timestamp),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      letterSpacing: 0,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  verticalSpace(5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
