import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/chats/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({super.key, required this.filterIndex});
  final int filterIndex;
  static const List<String> filters = ['All', 'Unread', 'Favourite', 'Groups'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        final cubit = context.read<ChatsCubit>();
        final isSelected = filterIndex == cubit.selectedFilterIndex;

        return GestureDetector(
          onTap: () {
            cubit.changeSelectedChatFilter(filterIndex);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.read<ChangeThemeCubit>().isDark
                        ? AppColors.chatActiveFilterDarkBackground
                        : AppColors.chatActiveFilterBackground
                  : context.read<ChangeThemeCubit>().isDark
                  ? Colors.grey.shade900.withAlpha(170)
                  : AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(19.0),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    filters[filterIndex],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? context.read<ChangeThemeCubit>().isDark
                                ? AppColors.chatActiveFilterBackground
                                : AppColors.chatActiveFilterText
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),

                  if (filterIndex == 1 && cubit.unreadChatsCount > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        cubit.unreadChatsCount > 99
                            ? '99+'
                            : cubit.unreadChatsCount.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? AppColors.chatActiveFilterText
                              : AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
