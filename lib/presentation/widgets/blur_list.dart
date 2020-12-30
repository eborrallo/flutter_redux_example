import 'package:flutter/material.dart';

class BlurList extends StatelessWidget {
  final Axis direction;
  final Widget child;
  BlurList(this.direction, this.child);
  @override
  Widget build(BuildContext context) {
    return direction == Axis.horizontal
        ? blurLeftRight(child)
        : blurTopBottom(child);
  }

  Widget blurTopBottom(Widget child) {
    return ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red,
              Colors.transparent,
              Colors.transparent,
              Colors.red
            ],
            stops: [
              0.0,
              0.02,
              0.98,
              1.0
            ], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: child);
  }

  Widget blurLeftRight(Widget child) {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [
              Colors.white,
              Colors.transparent,
              Colors.transparent,
              Colors.white
            ],
            stops: [0, 0.02, 0.98, 1],
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstOut,
        child: child);
  }
}
