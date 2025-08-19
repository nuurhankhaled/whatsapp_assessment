import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/chats/presentation/manager/chats_cubit/chats_cubit.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({super.key, required this.filterIndex});
  final int filterIndex;
  static const List<String> filters = ['All', 'Unread', 'Favourite', 'Groups'];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<ChatsCubit>().changeSelectedChatFilter(filterIndex);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            decoration: BoxDecoration(
              color:
                  (filterIndex ==
                      context.read<ChatsCubit>().selectedFilterIndex)
                  ? AppColors.chatActiveFilterBackground
                  : AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(19.0),
            ),
            child: Center(
              child: Text(
                filters[filterIndex],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      (filterIndex ==
                          context.read<ChatsCubit>().selectedFilterIndex)
                      ? AppColors.chatActiveFilterText
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
