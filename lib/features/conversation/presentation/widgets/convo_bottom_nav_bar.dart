import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class ConvoBottomNavBar extends StatefulWidget {
  const ConvoBottomNavBar({super.key});

  @override
  State<ConvoBottomNavBar> createState() => _ConvoBottomNavBarState();
}

class _ConvoBottomNavBarState extends State<ConvoBottomNavBar> {
  final FocusNode _textFieldFocus = FocusNode();
  bool _isTextFieldFocused = false;

  @override
  void initState() {
    super.initState();
    _textFieldFocus.addListener(() {
      setState(() {
        _isTextFieldFocused = _textFieldFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _textFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedContainer(
      duration: Duration.zero,
      curve: Curves.easeInOut, // Smooth curve
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        width: double.infinity,
        height: _isTextFieldFocused ? 50 : 77, // Based on focus, not keyboard
        color: AppColors.conversationBarsLightBackground.withAlpha(220),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(Assets.images.convoPlusIcon.path, width: 27),
            ),
            Expanded(
              child: AnimatedPadding(
                duration: Duration.zero,
                curve: Curves.easeInOut,
                padding: const EdgeInsets.only(top: 11.0),
                child: AnimatedContainer(
                  duration: Duration.zero,
                  curve: Curves.easeInOut,
                  height: _isTextFieldFocused ? 28 : 30,
                  child: TextField(
                    focusNode: _textFieldFocus,
                    cursorHeight: 14.0,
                    textAlignVertical: TextAlignVertical.center,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                          left: 4.5,
                          top: 4.5,
                          bottom: 4.5,
                        ),
                        child: Image.asset(Assets.images.sticker.path),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.grey.withAlpha(100),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.grey.withAlpha(100),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.grey.withAlpha(100),
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 12),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPadding(
              duration: Duration.zero,
              curve: Curves.easeInOut,
              padding: EdgeInsets.only(
                left: 16.0,
                top: _isTextFieldFocused ? 10 : 12,
              ),
              child: Image.asset(Assets.images.convoCamera.path, width: 27),
            ),
            AnimatedPadding(
              duration: Duration.zero,
              curve: Curves.easeInOut,
              padding: EdgeInsets.only(
                left: 8.0,
                top: _isTextFieldFocused ? 10 : 12,
                right: 5,
              ),
              child: Image.asset(Assets.images.mic.path, width: 27),
            ),
          ],
        ),
      ),
    );
  }
}
