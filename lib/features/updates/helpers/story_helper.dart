import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/features/updates/helpers/animations_helper.dart';
import 'package:whatsapp_assessment/features/updates/presentation/manager/status_cubit/status_cubit.dart';

class StoryHelper {
  final BuildContext context;
  final StoryAnimationHelper animationHelper;
  final VoidCallback onExit;
  final Function(bool) onPageTransition;

  Timer? _resumeTimer;

  StoryHelper({
    required this.context,
    required this.animationHelper,
    required this.onExit,
    required this.onPageTransition,
  });

  StatusCubit get _cubit => context.read<StatusCubit>();

  void startStoryTimer(VoidCallback onComplete) {
    if (_cubit.isTransitioning) return;
    animationHelper.startProgress();
    _cubit.startStoryTimer(onComplete);
  }

  void nextStory() {
    _cubit.nextStory();
    if (_cubit.isTransitioning) {
      onPageTransition(true);
    } else if (_cubit.shouldExitViewer()) {
      onExit();
    } else {
      startStoryTimer(nextStory);
    }
  }

  void previousStory() {
    _cubit.previousStory();
    if (_cubit.isTransitioning) {
      onPageTransition(false);
    } else {
      startStoryTimer(nextStory);
    }
  }

  void pauseStory() {
    _cubit.pauseStory();
    animationHelper.stopProgress();
  }

  void resumeStory() {
    if (_cubit.isTransitioning) return;
    _cubit.resumeStory();
    animationHelper.resumeProgress();

    _resumeTimer?.cancel();
    _resumeTimer = animationHelper.createResumeTimer(
      nextStory,
      animationHelper.progressController.value,
    );
  }

  void dispose() {
    _resumeTimer?.cancel();
  }
}
