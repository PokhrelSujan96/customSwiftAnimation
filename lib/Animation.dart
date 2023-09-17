// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenScreenState createState() => _AnimationScreenScreenState();
}

class _AnimationScreenScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double percentage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {
          percentage = (_controller.value * 100).roundToDouble();
        });
      });
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5.r)),
              width: 10.h,
              height: 150.h,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: ClipPath(
                      clipper: Paint_loadingBar(_controller.value),
                      child: Container(
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            '$percentage%',
            style: GoogleFonts.electrolize(
              fontSize: 9.sp,
              letterSpacing: 1.r,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Paint_loadingBar extends CustomClipper<Path> {
  final double animationValue;

  Paint_loadingBar(this.animationValue);

  @override
  Path getClip(Size size) {
    final path = Path();

    final topEdgeY = size.height * (1 - animationValue);

    path.moveTo(0, topEdgeY);
    path.lineTo(size.width, topEdgeY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
