import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 46,
      child: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        backgroundColor: Colors.white,
        child: Image.asset(
          Assets.images.metaAiLogo.path,
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}
