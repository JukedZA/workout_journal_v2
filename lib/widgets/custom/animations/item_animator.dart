import 'package:flutter/material.dart';

enum Position { left, right, top, bottom }

class SlideContainer extends StatefulWidget {
  final Widget child;
  final Position pos;

  const SlideContainer({
    Key? key,
    required this.child,
    required this.pos,
  }) : super(key: key);

  @override
  State<SlideContainer> createState() => _SlideContainerState();
}

class _SlideContainerState extends State<SlideContainer>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late Offset _position;

  final Map<Position, Offset> _positions = {
    Position.bottom: const Offset(0, 1),
    Position.top: const Offset(0, -1),
    Position.left: const Offset(-1, 0),
    Position.right: const Offset(1, 0),
  };

  @override
  void initState() {
    super.initState();

    _position = _positions[widget.pos]!;

    // Slide Animation
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250), // Adjust the slide duration
    );

    _slideAnimation = Tween<Offset>(
      begin: _position, // Start from left
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeOut,
      ),
    );

    // Fade Animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750), // Adjust the fade duration
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.linear, // Adjust the fade curve as needed
      ),
    );

    // Start both animations
    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_slideAnimation, _fadeAnimation]),
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class ScaleContainer extends StatefulWidget {
  final Widget child;

  const ScaleContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ScaleContainer> createState() => _ScaleContainerState();
}

class _ScaleContainerState extends State<ScaleContainer>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Scale Animation
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Adjust the scale duration
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );

    // Start fade animation
    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  // Function to trigger the scale animation
  void _startScaleAnimation() {
    _scaleController.reset(); // Reset the animation
    _scaleController.forward(); // Start the scale animation
  }

  // Function to end the animation by playing it in reverse
  void _endAnimation() {
    _scaleController.reverse(); // Reverse the animation
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Align(
          alignment: Alignment.topCenter,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            alignment: Alignment.topCenter,
            child: widget.child,
          ),
        );
      },
    );
  }
}
