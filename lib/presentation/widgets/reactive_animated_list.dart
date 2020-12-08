import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/services/WidgetFactory.dart';

class ReactiveAnimatedList extends StatefulWidget {
  final List<dynamic> list;
  final WidgetFactroy creator;
  Axis scrollDirection;
  int length;

  ReactiveAnimatedList(this.list,this.creator, {this.length, this.scrollDirection, });
  @override
  _ReactiveAnimatedListState createState() => _ReactiveAnimatedListState();
}

class _ReactiveAnimatedListState extends State<ReactiveAnimatedList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void didUpdateWidget(ReactiveAnimatedList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.list != null && oldWidget.list != widget.list) {
      oldWidget.list.forEach((element) {
        if (!widget.list.contains(element)) {
          _listKey.currentState.removeItem(
              oldWidget.list.indexOf(element),
              (context, animation) =>
                  _buildItem(context, element, animation));
          Future.delayed(Duration(milliseconds: 200), () {
            var nextiIndex = 1;
            if (widget.list.asMap().containsKey(nextiIndex)) {
              _listKey.currentState.insertItem(nextiIndex);
            }
          });
        }
      });
    } else if (oldWidget.list == null && oldWidget.list != widget.list) {
      Future.delayed(Duration(milliseconds: 1), () {
        _listKey.currentState.insertItem(0);
      });
      Future.delayed(Duration(milliseconds: 200), () {
        _listKey.currentState.insertItem(1);
      });
    }
  }

  Widget _buildItem(BuildContext context, dynamic item, animation) {
    return FadeTransition(
      child: widget.creator.create(item),
      opacity: animation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.list == null
            ? []
            : [
                Expanded(
                    child: AnimatedList(
                        key: _listKey,
                        initialItemCount: 0,
                        itemBuilder: (context, index, animation) => _buildItem(
                            context, widget.list[index], animation)))
              ]);
  }
}
