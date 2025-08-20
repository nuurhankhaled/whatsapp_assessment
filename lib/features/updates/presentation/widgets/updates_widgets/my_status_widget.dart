import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';
import 'package:whatsapp_assessment/generated/translations/locale_keys.g.dart';

class MyStatusWidget extends StatelessWidget {
  const MyStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
         spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
          tr(LocaleKeys.status),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            spacing: 15,
            children: [
              Stack(
                children: [
                  Container(
                    width: 53,
                    height: 53,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withAlpha(100),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStDU02vFJPYpZo22OeRcIvI7IaIm3ijEkSYQ&s',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0),
                        shape: BoxShape.circle,
                        color: AppColors.tealColor,
                      ),
                      child: Image.asset(Assets.images.plusIcon.path),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("Add status"),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 0,
                    ),
                  ),
                  Text(
                    tr("Disappears after 24 hours"),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 34,
                height: 34,
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightGreyBackground,
                ),
                child: Image.asset(Assets.images.addPhoto.path),
              ),
              Container(
                width: 34,
                height: 34,
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightGreyBackground,
                ),
                child: Image.asset(Assets.images.type.path),
              ),
            ],
          ),
        ),
    
        ],
      ),
    );
  }
}
