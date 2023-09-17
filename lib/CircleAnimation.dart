// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleIndicator extends StatefulWidget {
  final double height;
  final double width;
  final Color color;
  final int duration;
  const CustomCircleIndicator({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.duration,
  }) : super(key: key);
  @override
  _CustomCircleIndicatorState createState() => _CustomCircleIndicatorState();
}

class _CustomCircleIndicatorState extends State<CustomCircleIndicator>
    with TickerProviderStateMixin {
  double _animationValue = 0.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {
          _animationValue = _animation.value;
        });
      });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 300.h,
                width: 300.w,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: CustomPaint(
                  size: const Size(100.0, 200.0),
                  painter: animationPainter(_animationValue, widget.color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleAnimation extends StatelessWidget {
  const CircleAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 300.h,
        width: 300.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            CustomCircleIndicator(
              width: 300.w,
              height: 300.h,
              color: Colors.deepPurpleAccent,
              duration: 18,
            ),
            CustomCircleIndicator(
                width: 270.w,
                height: 270.h,
                color: Colors.yellow,
                duration: 17),
            CustomCircleIndicator(
                width: 240.w, height: 240.h, color: Colors.red, duration: 16),
            CustomCircleIndicator(
                width: 210.w, height: 210.h, color: Colors.white, duration: 15),
            CustomCircleIndicator(
                width: 180.w, height: 180.h, color: Colors.green, duration: 14),
            CustomCircleIndicator(
                width: 150.w, height: 150.h, color: Colors.blue, duration: 13),
            CustomCircleIndicator(
                width: 120.w,
                height: 120.h,
                color: Colors.orange,
                duration: 12),
            CustomCircleIndicator(
                width: 90.w, height: 90.h, color: Colors.grey, duration: 11),
            CustomCircleIndicator(
                width: 60.w, height: 60.h, color: Colors.lime, duration: 10),
            CustomCircleIndicator(
                width: 30.w, height: 30.h, color: Colors.red, duration: 9),
          ],
        ),
      ),
    ));
  }
}

class animationPainter extends CustomPainter {
  final Color color;
  final double value;

  animationPainter(this.value, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final path = Path();
    final sweepAngle = 2 * pi * value;
    final startAngle = -pi / 2;

    path.addArc(
        Rect.fromCircle(
            center: size.center(Offset.zero),
            radius: (size.width - paint.strokeWidth) / 2),
        startAngle,
        sweepAngle);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
