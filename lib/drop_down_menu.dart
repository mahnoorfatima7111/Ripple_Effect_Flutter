import 'dart:math';
import 'package:flutter/material.dart';

class DropDownMenu extends StatelessWidget {
  const DropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> dropDownItems = [
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
      'Option 5',
      'Option 6',
      'Option 7',
      // 'Option 8',
    ];

    return Scaffold(
      backgroundColor: Colors.purple.shade100,

      // appBar: AppBar(title: Text('Drop Down Menu')),
      body: Padding(
        padding: const EdgeInsets.only(left: 225, top: 30),
        child: SizedBox(
          width: 800,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: AnimatedDropDown(
                  items: dropDownItems,
                  hint: "Elastic Dropdown",
                  animationType: DropdownAnimationType.elastic,
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: AnimatedDropDown(
                  items: dropDownItems,
                  hint: "Flip Dropdown",
                  animationType: DropdownAnimationType.flip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define the DropdownAnimationType enum
enum DropdownAnimationType { elastic, flip }

class AnimatedDropDown extends StatefulWidget {
  final List<String> items;
  final String hint;
  final DropdownAnimationType animationType;
  final ValueChanged<String>? onItemSelected;
  const AnimatedDropDown({
    super.key,
    required this.items,
    required this.hint,
    required this.animationType,
    this.onItemSelected,
  });

  @override
  State<AnimatedDropDown> createState() => _AnimatedDropDownState();
}

class _AnimatedDropDownState extends State<AnimatedDropDown>
    with TickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  String? _selectedItem;
  final GlobalKey _buttonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() => setState(() {}));
    _selectedItem = widget.hint;
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        // Use a different curve for reverse based on animation type
        if (widget.animationType == DropdownAnimationType.elastic) {
          // For elastic, just reverse normally; curve is handled in the widget
          _controller.reverse();
        } else {
          // For flip, just reverse normally
          _controller.reverse();
        }
      }
    });
  }

  void _onItemSelected(String item) {
    setState(() {
      _selectedItem = item;
      _isOpen = false;
    });
    if (widget.animationType == DropdownAnimationType.elastic) {
      _controller.reverse();
    } else {
      _controller.reverse();
    }
    widget.onItemSelected?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    // var icon;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: toggle,
          child: Container(
            key: _buttonKey,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple,
                  const Color.fromARGB(255, 161, 109, 251),
                  Colors.deepPurple,

                  // const Color.fromARGB(255, 198, 78, 219),
                  // const Color.fromARGB(255, 238, 145, 254),
                  // const Color.fromARGB(255, 198, 78, 219),

                  // Color.fromARGB(255, 191, 255, 232), // pastel green
                  // Color(0xFFDCE8F2), // pastel blue/grey
                  // Color(0xFFFFD3B6), // pastel peach
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    _selectedItem ?? widget.hint,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: RotationTransition(
                    turns: _rotationAnimation,
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                  onPressed: toggle,
                ),
              ],
            ),
          ),
        ),

        // SizedBox(height: 10),
        if (_isOpen || _controller.value > 0.0)
          (widget.animationType == DropdownAnimationType.elastic
              ? _buildElasticMenu(context)
              : _buildFlipMenu(context)),
      ],
    );
  }

  Widget _buildElasticMenu(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: _controller,
        curve: _isOpen ? Curves.elasticInOut : Curves.elasticOut,
      ),
      child: Container(
        // width: ,
        // color: Colors.white.withAlpha(100),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.items
              .map(
                (item) => ListTile(
                  title: Text(item),
                  onTap: () => _onItemSelected(item),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildFlipMenu(BuildContext context) {
    final angle = (1 - _controller.value) * pi / 2;
    final effectiveAngle = _isOpen ? angle : (pi / 2) * _controller.value;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(angle),
          child: Opacity(opacity: _controller.value, child: child),
        );
      },
      child: Container(
        // color: Colors.white.withAlpha(100),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.items
              .map(
                (item) => ListTile(
                  title: Text(item),
                  onTap: () => _onItemSelected(item),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
