import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/services/WidgetFactory.dart';

class ReactiveAnimatedList extends StatefulWidget {
  final List<dynamic> list;
  final WidgetFactroy creator;
  Axis scrollDirection;
  int length;

  ReactiveAnimatedList(
    this.list,
    this.creator, {
    this.length,
    this.scrollDirection = Axis.vertical,
  });
  @override
  _ReactiveAnimatedListState createState() => _ReactiveAnimatedListState();
}

class _ReactiveAnimatedListState extends State<ReactiveAnimatedList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  bool _deleteItem(oldWidget) {
    bool deleted = false;
    oldWidget.list.forEach((element) {
      if (!widget.list.contains(element)) {
        _listKey.currentState.removeItem(oldWidget.list.indexOf(element),
            (context, animation) => _buildItem(context, element, animation));
        deleted = true;
      }
    });
    return deleted;
  }

  void _addItem(index) {
    Future.delayed(Duration(milliseconds: index * 200), () {
      if (widget.list.asMap().containsKey(index)) {
        _listKey.currentState.insertItem(index);
      }
    });
  }

  @override
  void didUpdateWidget(ReactiveAnimatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.list != null && oldWidget.list.length != widget.list.length) {
      if (_deleteItem(oldWidget)) {
        _addItem(1);
      }
    } else if (oldWidget.list == null && oldWidget.list != widget.list) {
      int _length = widget.length ?? widget.list.length;
      for (var i = 0; i < _length; i++) {
        _addItem(i);
      }
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
                  itemBuilder: (context, index, animation) {
                    return _buildItem(context, widget.list[index], animation);
                  },
                  scrollDirection: widget.scrollDirection,
                ))
              ]);
  }
}
