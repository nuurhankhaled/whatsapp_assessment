import 'dart:async';
import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/features/updates/data/models/story_viewer_configurations.dart';

class StoryAnimationHelper {
  late AnimationController _progressController;
  late AnimationController _dismissController;
  Animation<double>? _dragAnimation;

  StoryAnimationHelper(TickerProvider vsync) {
    _progressController = AnimationController(
      duration: StoryViewerConfig.storyDuration,
      vsync: vsync,
    );
    _dismissController = AnimationController(
      duration: StoryViewerConfig.dragAnimationDuration,
      vsync: vsync,
    );
  }

  AnimationController get progressController => _progressController;
  AnimationController get dismissController => _dismissController;
  Animation<double>? get dragAnimation => _dragAnimation;

  void startProgress() {
    _progressController.reset();
    _progressController.forward();
  }

  void stopProgress() {
    _progressController.stop();
  }

  void resumeProgress() {
    _progressController.forward();
  }

  void animateDragTo(
    double target,
    double currentOffset,
    VoidCallback onUpdate,
    VoidCallback onComplete,
  ) {
    _dragAnimation = Tween<double>(begin: currentOffset, end: target).animate(
      CurvedAnimation(
        parent: _dismissController,
        curve: StoryViewerConfig.dragAnimationCurve,
      ),
    )..addListener(onUpdate);

    _dismissController.value = 0.0;
    _dismissController.forward().then((_) => onComplete());
  }

  Timer createResumeTimer(VoidCallback callback, double progressValue) {
    final remainingDuration = Duration(
      milliseconds:
          (StoryViewerConfig.storyDuration.inMilliseconds * (1 - progressValue))
              .round(),
    );
    return Timer(remainingDuration, callback);
  }

  void dispose() {
    _progressController.dispose();
    _dismissController.dispose();
  }
}
