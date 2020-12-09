import 'dart:math';

import 'package:flutter/material.dart';

typedef ItemBuilder = Widget Function(BuildContext context, dynamic itemData);
class BetterAnimatedList extends StatefulWidget {
  BetterAnimatedList(
      {@required this.list, @required this.itemBuilder, this.header});

  final List list;
  final Widget header;
  final ItemBuilder itemBuilder;

  @override
  _BetterAnimatedListState createState() => _BetterAnimatedListState();
}

class _BetterAnimatedListState extends State<BetterAnimatedList> {
  var key = GlobalKey<AnimatedListState>();
  List list;

  @override
  void initState() {
    super.initState();
    list = List.from(widget.list);
  }

  @override
  Widget build(BuildContext context) {
    var newList = widget.list;

    var i = 0;
    while (i < max(list.length, newList.length)) {
      if (i >= list.length) {
        addItem(list, i, newList[i]);
        i++;
      } else if (i >= newList.length) {
        removeItem(list, i);
      } else {
        var item = list[i];
        var newItem = newList[i];
        if (newItem != item) {
          if (newList.contains(item)) {
            addItem(list, i, newItem);
            i++;
          } else {
            removeItem(list, i);
          }
        } else {
          i++;
        }
      }
    }

    return AnimatedList(
      key: key,
      initialItemCount: list.length + 1,
      itemBuilder: (context, index, animation) {
        if (index == 0) {
          return widget.header ?? Container();
        }
        return buildListItem(context, list[index - 1], animation);
      },
    );
  }

  Widget buildListItem(context, itemData, animation) {
    return SizeTransition(
      key: Key(itemData.hashCode.toString()),
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
      child: FadeTransition(
        opacity: animation,
        child: widget.itemBuilder(context, itemData),
      ),
    );
  }

  removeItem(list, index) {
    var state = key.currentState;
    var item = list[index];
    state.removeItem(index + 1, (context, animation) {
      return buildListItem(context, item, animation);
    });

    list.removeAt(index);
  }

  addItem(list, index, item) {
    var state = key.currentState;
    list.insert(index, item);
    state.insertItem(index + 1);
  }
}