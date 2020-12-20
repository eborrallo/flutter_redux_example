import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/UserService.dart';
import 'package:flutter_redux_boilerplate/application/notifier/UserNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/services/Auth.dart';
import 'package:flutter_redux_boilerplate/domain/user/user.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_redux_boilerplate/infraestructure/NavigationService.dart';

import '../mocks/FirebaseAuthMock.dart';

void main() {
  group('Main screen', () {
    Widget sut;
    configureInjection(Environment.test);

    setUp(() {
      var navigationService = getIt<NavigationService>();
      Auth authMock = FirebaseAuthMock();
      when(authMock.getSignedInUser()).thenReturn(new User('email', 'uid'));
      var userNotifier =
          new UserNotifier(app: new UserService(authService: authMock));
      var appNotifier = getIt<AppNotifier>();
      sut = new CalendarApp(
        navigationService: navigationService,
        userNotifier: userNotifier,
        appNotifier: appNotifier,
      );
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
        await tester.runAsync(() async {
          await tester.pumpWidget(sut);
          await tester.pumpAndSettle();

          expect(find.text('Almost Due'), findsOneWidget);
        });
      });
      testWidgets('We can see the "Today Class" widgest',
          (WidgetTester tester) async {
        await tester.runAsync(() async {
          await tester.pumpWidget(sut);
          await tester.pumpAndSettle();

          expect(find.text('Today Class'), findsOneWidget);
        });
      });
    });
    testWidgets('We can see the bottom float action button and childs',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
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
    });
    testWidgets('We can see and navigate using the bottom bar buttons',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(sut);
        await tester.pumpAndSettle();

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

    testWidgets('We can see and navigate using the drawer menu buttons',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(sut);
        var menuButton = find.byIcon(Icons.menu);
        expect(menuButton, findsOneWidget);
        await tester.tap(menuButton);
        await tester.pumpAndSettle();

        expect(find.widgetWithIcon(ListTile, Icons.home), findsOneWidget);
        expect(find.widgetWithIcon(ListTile, Icons.timeline), findsOneWidget);
        expect(find.widgetWithIcon(ListTile, Icons.assignment), findsOneWidget);
        expect(find.widgetWithIcon(ListTile, Icons.assignment_ind),
            findsOneWidget);
        expect(
            find.widgetWithIcon(ListTile, Icons.exit_to_app), findsOneWidget);
      });
    });
  });
}
