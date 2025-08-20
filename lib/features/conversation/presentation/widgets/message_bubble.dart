import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:whatsapp_assessment/core/extensions/spacing.dart';
import 'package:whatsapp_assessment/core/theme/app_colors.dart';
import 'package:whatsapp_assessment/generated/assets.gen.dart';

class MessageBubble extends StatelessWidget {
  final bool isSender;
  final String text;
  final bool tail;
  final Color color;
  final bool sent;
  final bool delivered;
  final bool seen;
  final BoxConstraints? constraints;

  const MessageBubble({
    super.key,
    this.isSender = true,
    this.constraints,
    required this.text,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
  });

  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Widget? messageStatus;
    if (sent) {
      stateTick = true;
      messageStatus = Image.asset(
        Assets.images.sentMessage.path,
        width: 15,
        height: 15,
      );
    }
    if (delivered) {
      stateTick = true;
      messageStatus = Image.asset(
        Assets.images.deliveredMessage.path,
        width: 15,
        height: 15,
      );
    }
    if (seen) {
      stateTick = true;
      messageStatus = Image.asset(
        Assets.images.seenMessage.path,
        width: 15,
        height: 15,
      );
    }
return Align(
  alignment: isSender ? Alignment.topRight : Alignment.topLeft,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    child: CustomPaint(
      painter: _MessageBubble(
        borderColor: AppColors.navBarBorder.withAlpha(50),
        color: color,
        alignment: isSender ? Alignment.topRight : Alignment.topLeft,
        tail: tail,
      ),
      child: Container(
        constraints: constraints ??
            BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .7,
            ),
        margin: isSender
            ? stateTick
                ? const EdgeInsets.fromLTRB(7, 7, 14, 7)
                : const EdgeInsets.fromLTRB(7, 7, 17, 7)
            : const EdgeInsets.fromLTRB(17, 7, 7, 7),
        child: Column(
            mainAxisSize: MainAxisSize.min, // ADD THIS LINE
          crossAxisAlignment: isSender
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: stateTick && isSender
                  ? const EdgeInsets.only(left: 4, right: 10, bottom: 2)
                  : const EdgeInsets.only(left: 4, right: 4, bottom: 2),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            context.verticalSpace(5),
            Row(
  mainAxisSize: MainAxisSize.min,
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Text(
      "19:24" , 
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.textSecondary,
        fontSize: 11,
      ),
    ),
    context.horizontalSpace(5),
    if (messageStatus != null && stateTick && isSender) ...[
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: messageStatus,
      ),
    ],
  ],
),
          ],
        ),
      ),
    ),
  ),
);
  }
}

class _MessageBubble extends CustomPainter {
  final Color color;
  final Alignment alignment;
  final bool tail;
  final Color? borderColor;
  _MessageBubble({
    required this.color,
    required this.alignment,
    required this.tail,
    this.borderColor,
  });

  final double _radius = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    // Create the path for the bubble shape
    Path bubblePath = _createBubblePath(w, h);

    // Fill the bubble with background color
    canvas.drawPath(
      bubblePath,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );

    // Draw border if borderColor is provided
    if (borderColor != null) {
      canvas.drawPath(
        bubblePath,
        Paint()
          ..color = borderColor!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }
  }

  Path _createBubblePath(double w, double h) {
    var path = Path();

    if (alignment == Alignment.topRight) {
      if (tail) {
        /// starting point
        path.moveTo(_radius * 2, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right bubble curve
        path.quadraticBezierTo(
          w - _radius * 1.5,
          h,
          w - _radius * 1.5,
          h - _radius * 0.6,
        );

        /// bottom-right tail curve 1
        path.quadraticBezierTo(w - _radius * 1, h, w, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
          w - _radius * 0.8,
          h,
          w - _radius,
          h - _radius * 1.5,
        );

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);
      } else {
        /// starting point
        path.moveTo(_radius * 2, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right curve
        path.quadraticBezierTo(w - _radius, h, w - _radius, h - _radius * 1.5);

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);
      }
    } else {
      if (tail) {
        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);

        // bottom-right tail curve 1
        path.quadraticBezierTo(_radius * .8, h, 0, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
          _radius * 1,
          h,
          _radius * 1.5,
          h - _radius * 0.6,
        );

        /// bottom-left bubble curve
        path.quadraticBezierTo(_radius * 1.5, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
      } else {
        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);

        /// bottom-left curve
        path.quadraticBezierTo(_radius, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is! _MessageBubble ||
        oldDelegate.color != color ||
        oldDelegate.alignment != alignment ||
        oldDelegate.tail != tail ||
        oldDelegate.borderColor != borderColor;
  }
}
