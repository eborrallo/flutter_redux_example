import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomSheet extends StatefulWidget {
  final Widget Function(Function) childBuilder;
  final double min;
  final double max;

  const BottomSheet({
    Key key,
   this.childBuilder,
    this.min: 0.25,
    this.max: 0.8,
  }) : super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    animation =
        Tween(begin: widget.min, end: widget.max).animate(animationController);
  }

  _toggle() {
        if (animationController.value == widget.max) {
      animationController.animateTo(widget.min,
          duration: Duration(milliseconds: 200), curve: Curves.bounceOut);
    } else {
      animationController.animateTo(widget.max,
          duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: _sheet(animation),
      builder: (BuildContext context, Widget child) {
        return child; //we would need to modify child here i guess
      },
    );
  }

  Widget _sheet(Animation animation) {
    return DraggableScrollableSheet(
      initialChildSize: animation.value,
      minChildSize: animation.value,
      maxChildSize: widget.max,
      builder: (BuildContext context, ScrollController scrollController) =>
          SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: _toggle,
                    child: Container(
                      color: Colors.white.withAlpha(50),
                      width: double.infinity,
                      child: Chip(
                        label: Text('Expand'),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    height: 400,
                    width: 400,
                  ),
                ],
              )),
    );
  }
}
