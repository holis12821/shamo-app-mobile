import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';

class AnimatedCircleCloseButtonWidget extends StatefulWidget {
  const AnimatedCircleCloseButtonWidget({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<AnimatedCircleCloseButtonWidget> createState() =>
      _AnimatedCircleCloseButtonWidgetState();
}

class _AnimatedCircleCloseButtonWidgetState
    extends State<AnimatedCircleCloseButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      lowerBound: 0.95,
      upperBound: 1.0,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Container(
          width: CustomAppDimensions.kSizeMediumLarge,
          height: CustomAppDimensions.kSizeMediumLarge,
          decoration: const BoxDecoration(
            color: CustomAppTheme.kPrimaryColor,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.close,
              color: Color.fromRGBO(0, 0, 0, 0.85),
              size: CustomAppDimensions.kSizeMedium,
            ),
          ),
        ),
      ),
    );
  }
}
