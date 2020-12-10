import 'package:flutter/material.dart';

typedef ItemBuilder = Widget Function(BuildContext context, dynamic itemData);

class ReactiveAnimatedList extends StatefulWidget {
  final List<dynamic> list;
  final ItemBuilder itemBuilder;
  Axis scrollDirection;
  int length;

  ReactiveAnimatedList(
    this.list,
    this.itemBuilder, {
    this.length,
    this.scrollDirection = Axis.vertical,
  });
  @override
  _ReactiveAnimatedListState createState() => _ReactiveAnimatedListState();
}

class _ReactiveAnimatedListState extends State<ReactiveAnimatedList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool isEmty = true;
  bool _deleteItem(oldWidget) {
    bool deleted = false;
    if (oldWidget.list.length == 0) {
      return true;
    }
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
    print(oldWidget.list);
    print(widget.list);
    if (oldWidget.list != null) {
      if (oldWidget.list.length > widget.list.length) {
        if (_deleteItem(oldWidget)) {
          _addItem(1);
          isEmty = false;
        }
      } else if (oldWidget.list.length < widget.list.length) {
        _addItem(0);
        isEmty = false;
      }
    } else if (oldWidget.list == null && oldWidget.list != widget.list) {
      int _length = widget.length ?? widget.list.length;
      for (var i = 0; i < _length; i++) {
        _addItem(i);
        isEmty = false;
      }
    }
  }

  Widget _buildItem(BuildContext context, dynamic item, animation) {
    return FadeTransition(
      child: widget.itemBuilder(context, item),
      opacity: animation,
    );
  }

  @override
  Widget build(BuildContext context) {
    int _length = widget.length ?? widget.list.length;

    return Column(
        children: widget.list == null
            ? []
            : [
                Expanded(
                    child: AnimatedList(
                  key: _listKey,
                  initialItemCount: isEmty ? _length : 0,
                  itemBuilder: (context, index, animation) {
                    return _buildItem(context, widget.list[index], animation);
                  },
                  scrollDirection: widget.scrollDirection,
                ))
              ]);
  }
}
