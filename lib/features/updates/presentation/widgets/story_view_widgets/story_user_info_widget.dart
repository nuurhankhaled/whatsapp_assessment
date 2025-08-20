import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/functions/date_format.dart';
import 'package:whatsapp_assessment/features/updates/presentation/manager/status_cubit/status_cubit.dart';

class StoryUserInfoWidget extends StatelessWidget {
  const StoryUserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusCubit, StatusState>(
      buildWhen: (previous, current) {
        return current is StoryViewerUpdated;
      },
      builder: (context, state) {
        final cubit = context.read<StatusCubit>();

        if (cubit.currentPersonIndex >= cubit.statusList.length) {
          return const SizedBox.shrink();
        }
        final currentStory = cubit.currentPerson;

        return Positioned(
          top: MediaQuery.of(context).padding.top + 30,
          left: 0,
          right: 15,
          child: Row(
            children: [
              IconButton(
                onPressed: () => context.router.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(currentStory.sender.image),
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentStory.sender.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      getRelativeTime(currentStory.timestamp),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
