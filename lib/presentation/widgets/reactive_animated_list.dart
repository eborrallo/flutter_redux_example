import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/blur_list.dart';

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
        var oldElementIndex = oldWidget.list.indexOf(element);
        if (oldElementIndex < this.length() && oldElementIndex != -1) {
          try {
            _listKey.currentState.removeItem(
                oldWidget.list.indexOf(element),
                (context, animation) =>
                    _buildItem(context, element, animation));
            deleted = true;
          } on Exception catch (_) {
            throw Exception(_);
          }

          return;
        }
      }
    });
    return deleted;
  }

  int length() => widget.length ?? widget.list.length;

  void _addItemDelayed(index, list) {
    Future.delayed(Duration(milliseconds: index * 200), () {
      this._addItem(index, list);
    });
  }

  void _addItem(index, list) {
    if (widget.list.asMap().containsKey(index) && this.mounted) {
      _listKey.currentState.insertItem(index);
    }
  }

  @override
  void didUpdateWidget(ReactiveAnimatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.list != null) {
      if (oldWidget.list.length > widget.list.length) {
        if (_deleteItem(oldWidget)) {
          _addItem(1, widget.list);
          isEmty = false;
        }
      } else if (oldWidget.list.length < widget.list.length) {
        if (widget.list.length <= this.length()) {
          _addItem(0, widget.list);
          isEmty = false;
        }
      }
    } else if (oldWidget.list == null && oldWidget.list != widget.list) {
      for (var i = 0; i < this.length(); i++) {
        _addItemDelayed(i, widget.list);
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
    return Column(
        children: widget.list == null
            ? []
            : [
                Expanded(
                    child: BlurList(
                        widget.scrollDirection,
                        AnimatedList(
                          key: _listKey,
                          initialItemCount: isEmty ? this.length() : 0,
                          itemBuilder: (context, index, animation) {
                            if (index < this.length()) {
                              return _buildItem(
                                  context, widget.list[index], animation);
                            }
                          },
                          scrollDirection: widget.scrollDirection,
                        )))
              ]);
  }
}
