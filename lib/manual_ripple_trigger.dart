import 'package:flutter/material.dart';

class MyFloatingButton extends StatefulWidget {
  // String title = 'cbksbc';

  const MyFloatingButton({super.key});

  @override
  State<MyFloatingButton> createState() => _MyFloatingButtonState();
}

class _MyFloatingButtonState extends State<MyFloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _sizeAnimation = Tween<double>(begin: 55, end: 250).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onStartRipple() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: Text(
      // widget.title,
      // style: const TextStyle(fontWeight: FontWeight.bold),
      // ),
      // ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'Ripple on Button Pressed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Center(
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
                      color: Colors.deepPurple.withOpacity(0.5),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: FloatingActionButton(
              onPressed: _onStartRipple,
              elevation: 8,
              shape: CircleBorder(),
              child: const Icon(Icons.play_arrow),
            ),
          ),
        ],
      ),
    );
  }
}
