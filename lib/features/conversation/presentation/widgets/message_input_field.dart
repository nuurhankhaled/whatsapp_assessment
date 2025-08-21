import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/features/home/presentation/manager/change_theme_cubit/change_theme_cubit.dart';
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
                decoration: _buildInputDecoration(context),
              ),
              // Animating text overlay
              if (widget.animatingText.isNotEmpty)
                _buildAnimatingOverlay(context),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: (context.read<ChangeThemeCubit>().isDark)
          ? AppColors.chatBubbleDarkReciever
          : Colors.white,
      isDense: true,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(left: 4.5, top: 4.5, bottom: 4.5),
        child: Image.asset(
          Assets.images.sticker.path,
          color: context.read<ChangeThemeCubit>().isDark
              ? Colors.white
              : Colors.black,
        ),
      ),
      enabledBorder: _buildBorder(context),
      focusedBorder: _buildBorder(context),
      border: _buildBorder(context),
      contentPadding: const EdgeInsets.only(left: 12),
    );
  }

  OutlineInputBorder _buildBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: (context.read<ChangeThemeCubit>().isDark)
            ? AppColors.chatBubbleDarkReciever
            : Colors.grey.withAlpha(100),
      ),
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
                color: (context.read<ChangeThemeCubit>().isDark)
                    ? AppColors.chatBubbleDarkReciever
                    : Colors.white,
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
