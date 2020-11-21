import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class NavigateToNext {

  NavigateToNext({@required this.destination,this.pageTransition});

  final String destination;
  final PageTransitionType pageTransition;

}

class NavigateToNextAndReplace {

  NavigateToNextAndReplace( {@required this.destination, this.pageTransition});

  final String destination;
  final PageTransitionType pageTransition;

}

class NavigateBack {}