import 'dart:ui';
import 'package:flutter/material.dart';

/// کارت شیشه‌ای با blur و شفافیت (glassmorphism)
class Glass extends StatelessWidget {

  const Glass({
    super.key,
    required this.child,
    this.radius = 18,
    this.padding,
    this.opacity = 0.06,
  });
  final Widget child;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

