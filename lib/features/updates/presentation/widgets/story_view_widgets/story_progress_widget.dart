import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/features/updates/data/models/story_viewer_configurations.dart';
import 'package:whatsapp_assessment/features/updates/presentation/manager/status_cubit/status_cubit.dart';

class StoryProgressWidget extends StatelessWidget {
  final AnimationController progressController;

  const StoryProgressWidget({super.key, required this.progressController});

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

        final currentPerson = cubit.currentPerson;

        return Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 10,
          right: 10,
          child: Row(
            children: List.generate(
              currentPerson.stories.length,
              (index) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: StoryViewerConfig.progressBarSpacing,
                  ),
                  height: StoryViewerConfig.progressBarHeight,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: AnimatedBuilder(
                    animation: progressController,
                    builder: (context, child) {
                      double progress = 0.0;

                      if (!cubit.isTransitioning) {
                        if (index < cubit.currentStoryIndex) {
                          progress = 1.0;
                        } else if (index == cubit.currentStoryIndex) {
                          progress = progressController.value;
                        }
                      } else {
                        if (index < cubit.currentStoryIndex) {
                          progress = 1.0;
                        }
                      }

                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
