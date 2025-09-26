import 'package:flutter/material.dart';

class RipplesAnywhere extends StatefulWidget {
  const RipplesAnywhere({super.key});

  @override
  State<RipplesAnywhere> createState() => _RipplesAnywhereState();
}

class _RipplesAnywhereState extends State<RipplesAnywhere>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;
  Offset? _tapPosition;
  // Widget? child;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _sizeAnimation = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _opacityAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    // _controller
    //     .forward(); // Removed: _controller.forward(); // This was causing the issue
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlingTaps(TapDownDetails tap) {
    setState(() {
      _tapPosition = tap.globalPosition;
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 500, top: 40),
            child: Text(
              'Tap Anywhere On The Screen',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.brown.shade600,
              ),
            ),
          ),
          GestureDetector(
            onTapDown: _handlingTaps,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: AnimatedBuilder(
                animation: _controller,

                builder: (BuildContext context, Widget? child) {
                  if (_tapPosition == null || !_controller.isAnimating) {
                    return const SizedBox.shrink();
                  }

                  final double currentSize = _sizeAnimation.value;
                  final double left = _tapPosition!.dx - (currentSize / 2);
                  final double top = _tapPosition!.dy - (currentSize / 2);

                  return Stack(
                    children: <Widget>[
                      Positioned(
                        left: left,
                        top: top,
                        child: Opacity(
                          opacity: _opacityAnimation.value,
                          child: Container(
                            width: currentSize,
                            height: currentSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.brown.shade900.withAlpha(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/**
 * Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Repeated Ripple Effect',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Container(
                      width: _sizeAnimation.value,
                      height: _sizeAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.shade100.withValues(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
 */