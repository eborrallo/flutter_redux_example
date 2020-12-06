import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';

@immutable
class SubjectProgress {
  final String title;
  final String progress;

  SubjectProgress(Subject subject, progress)
      : title = subject.title,
        progress = progress;
}
