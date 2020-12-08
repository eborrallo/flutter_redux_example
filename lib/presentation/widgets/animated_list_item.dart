import 'package:flutter/material.dart';

class AnimatedListItem extends StatefulWidget {
  final int index;
  final String uuid;
  final Widget child;
  AnimatedListItem(this.index, this.child, {this.uuid, Key key})
      : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with TickerProviderStateMixin {
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        reverseDuration: const Duration(milliseconds: 1000),
        vsync: this);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutQuart);

    animation.addStatusListener((status) {});
    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation, child: widget.child);
  }
}
