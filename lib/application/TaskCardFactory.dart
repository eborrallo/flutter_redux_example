import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/TaskService.dart';
import 'package:flutter_redux_boilerplate/domain/services/WidgetFactory.dart';

import 'package:flutter_redux_boilerplate/presentation/widgets/task_card.dart';
import 'package:injectable/injectable.dart';

@injectable
class TasckCardFactroy implements WidgetFactroy {
  final TaskService taskService;
  TasckCardFactroy(this.taskService);

  Widget create(dynamic element) {
    return new TaskCard(
        element, this.taskService.timeLeft(element.deliveryDate));
  }
}
