import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_boilerplate/config/redux/app_reducer.dart';
import 'package:flutter_redux_boilerplate/config/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/core/screens/main/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

void main() {
  group('Main screen', () {
    testWidgets('We can see the widgest in the main ',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      Timer(const Duration(seconds: 5), () {});

      const Key innerKey = Key('main');
      MainScreen sut = MainScreen(key: innerKey);
      Store<AppState> store = new Store(
        appReducer,
        initialState: AppState(),
      );

      await tester.pumpWidget(StoreProvider<AppState>(
          store: store,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: const Text('Title')),
              body: sut,
            ),
          )));

      expect(find.text('On progress'), findsOneWidget);
      expect(find.text('Almost Due'), findsOneWidget);
      expect(find.text('Today Calss'), findsOneWidget);
      var addButton = find.widgetWithIcon(FloatingActionButton, Icons.add);
      print(addButton);
      expect(addButton, findsOneWidget);

      expect(find.byIcon(Icons.assignment), findsNothing);
      expect(find.byIcon(Icons.assignment_ind), findsNothing);
      expect(find.byIcon(Icons.assignment_turned_in), findsNothing);
      await tester.tap(addButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byIcon(Icons.assignment), findsOneWidget);
      expect(find.byIcon(Icons.assignment_ind), findsOneWidget);
      expect(find.byIcon(Icons.assignment_turned_in), findsOneWidget);
    });
  });
}
