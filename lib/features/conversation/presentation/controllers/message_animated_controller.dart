import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/features/conversation/data/models/conversation_model.dart';

class MessageAnimationController {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  MessageModel? _animatingMessage;

  MessageModel? get animatingMessage => _animatingMessage;
  AnimationController get controller => _controller;
  Animation<double> get scaleAnimation => _scaleAnimation;
  Animation<double> get opacityAnimation => _opacityAnimation;
  Animation<Offset> get slideAnimation => _slideAnimation;

  void initialize(TickerProvider vsync) {
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 400,
      ), // Reduced to match text animation
      vsync: vsync,
    );

    // Start scale immediately
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack),
      ),
    );

    // Start opacity immediately
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Slide animation starts immediately too
    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0.5), // Start from below
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
          ),
        );
  }

  void startAnimation(MessageModel message) {
    _animatingMessage = message;
    _controller.forward();
  }

  void resetAnimation() {
    _animatingMessage = null;
    _controller.reset();
  }

  void dispose() {
    _controller.dispose();
  }
}
