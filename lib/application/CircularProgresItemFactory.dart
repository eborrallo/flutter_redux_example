import 'package:flutter/material.dart';

import 'package:flutter_redux_boilerplate/domain/services/WidgetFactory.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/circular_progress_item.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CircularProgresItemFactory implements WidgetFactroy {
  CircularProgresItemFactory();
  Widget create(dynamic element) {
    return new CircularProgresItem(
      text: element.title,
      progressValue: element.progress,
    );
  }
}
