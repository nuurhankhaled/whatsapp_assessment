import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/features/updates/helpers/story_helper.dart';
import 'package:whatsapp_assessment/features/updates/presentation/manager/status_cubit/status_cubit.dart';
import 'package:whatsapp_assessment/features/updates/presentation/widgets/story_view_widgets/story_content_widget.dart';

class StoryPageViewWidget extends StatelessWidget {
  final PageController pageController;
  final StoryHelper storyController;

  const StoryPageViewWidget({
    super.key,
    required this.pageController,
    required this.storyController,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: (index) {
        context.read<StatusCubit>().onPageChanged(index);
        storyController.startStoryTimer(storyController.nextStory);
      },
      itemCount: context.read<StatusCubit>().statusList.length,
      itemBuilder: (context, index) => AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          final transformData = _calculateTransform(index);
          return Transform(
            alignment: Alignment.centerRight,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(transformData['rotation']!),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.3 * (1 - transformData['scale']!),
                    ),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: StoryContentWidget(
                story: context.read<StatusCubit>().statusList[index],
                personIndex: index,
              ),
            ),
          );
        },
      ),
    );
  }

  Map<String, double> _calculateTransform(int index) {
    if (!pageController.position.haveDimensions) {
      return {'scale': 1.0, 'rotation': 0.0};
    }
    final value = pageController.page! - index;
    final scale = (1 - (value.abs() * 0.3)).clamp(0.5, 1.0);
    final rotation = value * math.pi / 6;
    return {'scale': scale, 'rotation': rotation};
  }
}
