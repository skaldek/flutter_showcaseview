import 'package:flutter/material.dart';

enum AnimationType { fade, scale }

class AnimationHandler extends StatefulWidget {
  final Widget child;
  final AnimationType animationType;
  final bool enabled;

  const AnimationHandler(
      {Key? key,
      required this.child,
      required this.animationType,
      required this.enabled})
      : super(key: key);

  @override
  AnimationHandlerState createState() => AnimationHandlerState();
}

class AnimationHandlerState extends State<AnimationHandler>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        value: widget.enabled ? 0.0 : 1.0,
        duration: const Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);
    if (widget.enabled) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.animationType) {
      case AnimationType.fade:
        return FadeTransition(opacity: _animation, child: widget.child);
      case AnimationType.scale:
        return ScaleTransition(scale: _animation, child: widget.child);
    }
  }
}
