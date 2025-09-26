import 'package:flutter/material.dart';

class RepeatedRipples extends StatefulWidget {
  // String title = 'cbksbc';

  const RepeatedRipples({super.key});

  @override
  State<RepeatedRipples> createState() => _RepeatedRipplesState();
}

class _RepeatedRipplesState extends State<RepeatedRipples>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat();
    _sizeAnimation = Tween<double>(begin: 0, end: 200).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(_controller);
    // _controller
    //     .forward(); // Removed: _controller.forward(); // This was causing the issue
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      body: Column(
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
                        // color: Colors.blue.shade100.withOpacity(0.5),
                      ),
                    ),
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
