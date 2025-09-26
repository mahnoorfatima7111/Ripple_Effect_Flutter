import 'package:flutter/material.dart';

class ContainerAnimation extends StatefulWidget {
  const ContainerAnimation({super.key});

  @override
  State<ContainerAnimation> createState() => _ContainerAnimationState();
}

class _ContainerAnimationState extends State<ContainerAnimation> {
  double height = 200, width = 200;
  Color color = Colors.black;

  // void _handlingTaps() {
  //   GestureDetector(
  //     onDoubleTap: () => setState(() {
  //       height = height == 200 ? 400 : 200;
  //       width = width == 200 ? 400 : 200;
  //       color = color == Colors.black ? Colors.amber : Colors.black;
  //     }),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration: Duration(seconds: 1));
  }
}
