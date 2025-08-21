import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class MessageInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isTextFieldFocused;
  final String animatingText;
  final AnimationController animationController;
  final Animation<double> opacityAnimation;
  final Animation<Offset> slideAnimation;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isTextFieldFocused,
    required this.animatingText,
    required this.animationController,
    required this.opacityAnimation,
    required this.slideAnimation,
  });

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedPadding(
        duration: Duration.zero,
        padding: const EdgeInsets.only(top: 11.0),
        child: AnimatedContainer(
          duration: Duration.zero,
          curve: Curves.easeInOut,
          height: widget.isTextFieldFocused ? 28 : 30,
          child: Stack(
            children: [
              // Regular TextField
              TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                cursorHeight: 14.0,
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontSize: 14),
                decoration: _buildInputDecoration(),
              ),
              // Animating text overlay
              if (widget.animatingText.isNotEmpty) _buildAnimatingOverlay(context),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(left: 4.5, top: 4.5, bottom: 4.5),
        child: Image.asset(Assets.images.sticker.path),
      ),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildBorder(),
      border: _buildBorder(),
      contentPadding: const EdgeInsets.only(left: 12),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.grey.withAlpha(100)),
    );
  }

  Widget _buildAnimatingOverlay(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return SlideTransition(
          position: widget.slideAnimation,
          child: Opacity(
            opacity: widget.opacityAnimation.value,
            child: Container(
              height: widget.isTextFieldFocused ? 28 : 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.withAlpha(100)),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    widget.animatingText,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(fontSize: 14),
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
