import 'package:flutter/material.dart';

class AnimatedListItem extends StatefulWidget {
  final int index;
  final String uuid;
  final Duration duration;
  final Widget child;
  AnimatedListItem(this.index, this.child, {this.uuid, Key key, this.duration})
      : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    const delayMiliseconds = 10000;
    const Duration _duration = Duration(milliseconds: delayMiliseconds);
    controller = AnimationController(
        duration: widget.duration ?? _duration,
        reverseDuration: widget.duration ?? _duration,
        vsync: this);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutQuart);
    double scaleDuration = ((widget.duration != null
                ? widget.duration.inMilliseconds
                : _duration.inMilliseconds) *
            200) /
        delayMiliseconds;
    animation.addStatusListener((status) {});
    Future.delayed(Duration(milliseconds: widget.index * scaleDuration.round()),
        () {
      if (this.mounted) {
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose(); 

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation, child: widget.child);
  }
}
