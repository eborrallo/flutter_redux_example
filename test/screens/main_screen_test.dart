import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_boilerplate/config/redux/app_reducer.dart';
import 'package:flutter_redux_boilerplate/config/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/core/screens/main/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:redux/redux.dart';

void main() {
  group('Main screen', () {
    Widget sut;
    setUp(() {
      Timer(const Duration(seconds: 5), () {});

      const Key innerKey = Key('main');
      MainScreen mainScreen = MainScreen(key: innerKey);
      Store<AppState> store = new Store(
        appReducer,
        initialState: AppState(),
      );

      sut = StoreProvider<AppState>(
          store: store,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: const Text('Title')),
              body: mainScreen,
            ),
          ));
    });
    group('Home tab', () {
      testWidgets('We can see the "On progress" widgest',
          (WidgetTester tester) async {
        await tester.pumpWidget(sut);
        await tester.pumpAndSettle();

        expect(find.text('On progress'), findsOneWidget);
      });
      testWidgets('We can see the "Almost Due" widgest',
          (WidgetTester tester) async {
        await tester.pumpWidget(sut);
        await tester.pumpAndSettle();

        expect(find.text('Almost Due'), findsOneWidget);
      });
      testWidgets('We can see the "Today Class" widgest',
          (WidgetTester tester) async {
        await tester.pumpWidget(sut);

        expect(find.text('Today Calss'), findsOneWidget);
      });
    });
    testWidgets(
        'We can see the "bottom float action button and childs" widgest',
        (WidgetTester tester) async {
      await tester.pumpWidget(sut);

      var addButton = find.widgetWithIcon(FloatingActionButton, Icons.add);
      expect(addButton, findsOneWidget);
      expect(find.byIcon(Icons.assignment), findsNothing);
      expect(find.byIcon(Icons.assignment_ind), findsNothing);
      expect(find.byIcon(Icons.assignment_turned_in), findsNothing);
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.assignment), findsOneWidget);
      expect(find.byIcon(Icons.assignment_ind), findsOneWidget);
      expect(find.byIcon(Icons.assignment_turned_in), findsOneWidget);
    });
    testWidgets('We can see the "bottom bar" widgest',
        (WidgetTester tester) async {
      await tester.pumpWidget(sut);

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      var workButton = find.widgetWithIcon(InkWell, Icons.work);
      expect(workButton, findsOneWidget);
      await tester.tap(workButton);
      await tester.pumpAndSettle();
      expect(find.text('Task'), findsOneWidget);

      initializeDateFormatting('es-ES');
      var calendarButton = find.widgetWithIcon(InkWell, Icons.calendar_today);
      expect(calendarButton, findsOneWidget);
      await tester.tap(calendarButton);
      await tester.pumpAndSettle();
      expect(find.text('Calendar'), findsOneWidget);

      var personButton = find.widgetWithIcon(InkWell, Icons.person);
      expect(personButton, findsOneWidget);
      await tester.tap(personButton);
      await tester.pumpAndSettle();
      expect(find.text('Profile'), findsOneWidget);
    });
  });
}
