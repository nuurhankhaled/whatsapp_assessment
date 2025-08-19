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
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        final cubit = ChatsCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  children: [
                    horizontalSpace(8),
                    const FiltersListViewWidget(),
                    const GreyPlusButton(),
                    horizontalSpace(8),
                  ],
                ),
              ),
              verticalSpace(5),
              if (cubit.selectedFilterIndex == 0 ||
                  cubit.selectedFilterIndex == 1)
                const ArchivedMessagesContainer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                layoutBuilder:
                    (Widget? currentChild, List<Widget> previousChildren) {
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          ...previousChildren,
                          if (currentChild != null) currentChild,
                        ],
                      );
                    },
                child: ListView.builder(
                  key: ValueKey(
                    '${cubit.filteredChats.length}-${cubit.filteredChats.hashCode}',
                  ),
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.filteredChats.length,
                  itemBuilder: (context, index) {
                    return ChatCard(model: cubit.filteredChats[index]);
                  },
                ),
              ),
              verticalSpace(100),
            ],
          ),
        );
      },
    );
  }
}
