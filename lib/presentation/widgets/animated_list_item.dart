import 'package:flutter/material.dart';

class AnimatedListItem extends StatefulWidget {
  final int index;
  Widget child;

  AnimatedListItem(this.index, this.child, {Key key}) : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        reverseDuration: const Duration(milliseconds: 1000),
        duration: const Duration(milliseconds: 1000),
        vsync: this);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutQuart);
    animation.addStatusListener((status) {
    });
    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose(); // you need this

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation, child: widget.child);
  }
}
