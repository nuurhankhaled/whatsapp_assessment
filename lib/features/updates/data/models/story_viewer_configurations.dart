import 'package:flutter/widgets.dart';

class StoryViewerConfig {
  static const Duration storyDuration = Duration(seconds: 5);
  static const Duration pageTransitionDuration = Duration(milliseconds: 800);
  static const Duration dragAnimationDuration = Duration(milliseconds: 300);
  static const Duration resumeDelay = Duration(milliseconds: 320);

  static const double dismissThreshold = 0.25;
  static const double dismissVelocityThreshold = 700.0;
  static const double progressBarHeight = 3.0;
  static const double progressBarSpacing = 2.0;

  static const Curve pageTransitionCurve = Curves.easeInOutCubic;
  static const Curve dragAnimationCurve = Curves.easeOut;
}
