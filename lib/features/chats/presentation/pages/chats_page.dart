import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/helpers/spacing.dart';
import 'package:whatsapp_assessment/features/chats/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:whatsapp_assessment/features/chats/presentation/widgets/archived_container.dart';
import 'package:whatsapp_assessment/features/chats/presentation/widgets/chat_card.dart';
import 'package:whatsapp_assessment/features/chats/presentation/widgets/filters_list_view_widget.dart';
import 'package:whatsapp_assessment/features/chats/presentation/widgets/grey_plus_button_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 8,
          children: [
            horizontalSpace(8),
            const FiltersListViewWidget(),
            const GreyPlusButton(),
            horizontalSpace(8),
          ],
        ),
        verticalSpace(5),
        const ArchivedMessagesContainer(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: context.read<ChatsCubit>().chatDataList.length,
            itemBuilder: (context, index) {
              return ChatCard(
                model: context.read<ChatsCubit>().chatDataList[index],
              );
            },
          ),
        ),
        verticalSpace(100),
      ],
    );
  }
}
