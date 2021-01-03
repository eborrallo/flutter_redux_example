import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/week_day_selector/week_day_selector.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('$WeekdaySelector constructor', () {
    test('initial values must not be null', () {
      expect(
        () => WeekdaySelector(onChanged: (_) {}, values: null),
        throwsAssertionError,
      );
    });

    test('weekdays must not be null', () {
      expect(
        () => WeekdaySelector(
          onChanged: (_) {},
          values: List.filled(7, false),
          weekdays: null,
        ),
        throwsAssertionError,
      );
    });

    test('shortWeekdays must not be null', () {
      expect(
        () => WeekdaySelector(
          onChanged: (_) {},
          values: List.filled(7, false),
          shortWeekdays: null,
        ),
        throwsAssertionError,
      );
    });

    test('values length must be 7', () {
      expect(
        () => WeekdaySelector(
          onChanged: (_) {},
          values: List.filled(6, false),
        ),
        throwsAssertionError,
      );
    });

    test('weekdays length must be 7', () {
      expect(
        () => WeekdaySelector(
          onChanged: (_) {},
          weekdays: List.filled(6, 'day'),
          values: List.filled(7, false),
        ),
        throwsAssertionError,
      );
    });

    test('shortWeekdays length must be 7', () {
      expect(
        () => WeekdaySelector(
          onChanged: (_) {},
          shortWeekdays: List.filled(6, 'D'),
          values: List.filled(7, false),
        ),
        throwsAssertionError,
      );
    });

    test('all weekdays values must be non-null strings', () {
      expect(
        () => WeekdaySelector(
          onChanged: (_) {},
          weekdays: [
            'Day A',
            'Day B',
            'Day C',
            'Day D',
            'Day E',
            'Day F',
            null,
          ],
          values: List.filled(7, false),
        ),
        throwsAssertionError,
      );
    });

    test('all shortWeekdays values must be non-null strings', () {
      expect(
        () => WeekdaySelector(
          onChanged: (_) {},
          shortWeekdays: ['A', 'B', 'C', 'D', 'E', 'F', null],
          values: List.filled(7, false),
        ),
        throwsAssertionError,
      );
    });
  });

  group('$WeekdayButton constructor', () {
    test('tooltip must be set', () {
      expect(
        () => WeekdayButton(
          onPressed: () {},
          tooltip: null,
          selected: null,
          text: 'Text',
        ),
        throwsAssertionError,
      );
    });

    test('tooltip must not be empty', () {
      expect(
        () => WeekdayButton(
          onPressed: () {},
          tooltip: '',
          selected: null,
          text: 'Text',
        ),
        throwsAssertionError,
      );
    });

    test('text must be set', () {
      expect(
        () => WeekdayButton(
          onPressed: () {},
          tooltip: 'Tooltip',
          selected: null,
          text: null,
        ),
        throwsAssertionError,
      );
    });

    test('text must not be empty', () {
      expect(
        () => WeekdayButton(
          onPressed: () {},
          tooltip: 'Tooltip',
          selected: null,
          text: '',
        ),
        throwsAssertionError,
      );
    });
  });

  group('$WeekdaySelector with simple default values', () {
    Widget widget;
    List<int> changed;

    setUp(() {
      changed = [];
      widget = MaterialApp(
        home: WeekdaySelector(
          onChanged: changed.add,
          values: const [true, false, false, false, false, false, true],
        ),
      );
    });

    testWidgets('displays a button for the 7 days of the week', (t) async {
      await t.pumpWidget(widget);
      final buttons = find.byType(WeekdayButton);
      expect(buttons, findsNWidgets(7));
      await t.pumpWidget(widget);
    });

    testWidgets(
      'marks days as selected based the values parameter',
      (t) async {
        await t.pumpWidget(widget);
        expect(
          find
              .byType(WeekdayButton)
              .evaluate()
              .map((e) => e.widget as WeekdayButton)
              .map((b) => b.selected)
              .toList(),
          [false, false, false, false, false, true, true],
        );
      },
    );

    testWidgets(
      'displays English weekday names as button texts starting with Monday',
      (t) async {
        await t.pumpWidget(widget);
        expect(
          find
              .byType(WeekdayButton)
              .evaluate()
              .map((e) => e.widget as WeekdayButton)
              .map((b) => b.text)
              .toList(),
          ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
        );
      },
    );

    testWidgets(
      'calls the onChanged method with the day index on tap',
      (t) async {
        await t.pumpWidget(widget);
        await t.tap(find.byTooltip('Tuesday'));
        expect(changed, [2]);
        await t.tap(find.byTooltip('Thursday'));
        expect(changed, [2, 4]);
      },
    );

    testWidgets(
      'uses English weekday names starting with Monday as tooltips',
      (t) async {
        await t.pumpWidget(widget);
        expect(
          find
              .byType(Tooltip)
              .evaluate()
              .map((e) => e.widget as Tooltip)
              .map((b) => b.message)
              .toList(),
          [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday',
          ],
        );
      },
    );
  });

  group('$WeekdaySelector with only the subset of the days displayed', () {
    Widget widget;
    List<int> changed;

    setUp(() {
      changed = [];
      widget = MaterialApp(
        home: WeekdaySelector(
          onChanged: changed.add,
          values: const [true, false, false, false, false, false, true],
          firstDayOfWeek: DateTime.sunday,
          displayedDays: {
            DateTime.monday,
            DateTime.wednesday,
            DateTime.friday,
            DateTime.sunday,
          },
        ),
      );
    });

    testWidgets(
        'displays only the buttons that corresponds to the displayed days argument',
        (t) async {
      await t.pumpWidget(widget);
      final buttons = find.byType(WeekdayButton);
      expect(buttons, findsNWidgets(4));
      await t.pumpWidget(widget);
    });

    testWidgets(
      'marks days as selected based the values parameter',
      (t) async {
        await t.pumpWidget(widget);
        expect(
          find
              .byType(WeekdayButton)
              .evaluate()
              .map((e) => e.widget as WeekdayButton)
              .map((b) => b.selected)
              .toList(),
          [true, false, false, false],
        );
      },
    );

    testWidgets(
      'displays selected weekday names as button texts starting with Monday',
      (t) async {
        await t.pumpWidget(widget);
        expect(
          find
              .byType(WeekdayButton)
              .evaluate()
              .map((e) => e.widget as WeekdayButton)
              .map((b) => b.text)
              .toList(),
          ['S', 'M', 'W', 'F'],
        );
      },
    );
  });

  group(
      '$WeekdaySelector with custom weekdays, tooltips and first day of '
      'the week from the intl package (Mexico)', () {
    Widget widget;
    List<int> changed;

    setUp(() {
      changed = [];
      // intl package's "first day of the week" notation is
      // inconsistent with dart-core's DateTime
      // For more info, see: https://github.com/dart-lang/intl/issues/265
      const firstDayOfWeekIntl = 6;
      const firstDayOfWeekDateTime = firstDayOfWeekIntl + 1;
      widget = MaterialApp(
          home: WeekdaySelector(
        onChanged: changed.add,
        values: const [true, false, false, false, false, false, true],
        weekdays: const [
          'domingo',
          'lunes',
          'martes',
          'miércoles',
          'jueves',
          'viernes',
          'sábado',
        ],
        shortWeekdays: const ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
        firstDayOfWeek: firstDayOfWeekDateTime, // Sunday
      ));
    });

    testWidgets('displays a button for the 7 days of the week', (t) async {
      await t.pumpWidget(widget);
      final buttons = find.byType(WeekdayButton);
      expect(buttons, findsNWidgets(7));
      await t.pumpWidget(widget);
    });

    testWidgets(
      'marks days as selected based the values parameter',
      (t) async {
        await t.pumpWidget(widget);
        expect(
          find
              .byType(WeekdayButton)
              .evaluate()
              .map((e) => e.widget as WeekdayButton)
              .map((b) => b.selected)
              .toList(),
          const [true, false, false, false, false, false, true],
        );
      },
    );

    testWidgets(
      'displays Spanish (MX) weekday names starting with Sunday',
      (t) async {
        await t.pumpWidget(widget);
        expect(
            find
                .byType(WeekdayButton)
                .evaluate()
                .map((e) => e.widget as WeekdayButton)
                .map((b) => b.text)
                .toList(),
            const ['D', 'L', 'M', 'M', 'J', 'V', 'S']);
      },
    );

    testWidgets(
      'calls the onChanged method with the day index on tap',
      (t) async {
        await t.pumpWidget(widget);
        await t.tap(find.byTooltip('martes'));
        expect(changed, [2]);
        await t.tap(find.byTooltip('jueves'));
        expect(changed, [2, 4]);
      },
    );

    testWidgets(
      'uses Spanish (MX) weekday names starting with Sunday as tooltips',
      (t) async {
        await t.pumpWidget(widget);
        expect(
          find
              .byType(Tooltip)
              .evaluate()
              .map((e) => e.widget as Tooltip)
              .map((b) => b.message)
              .toList(),
          const [
            'domingo',
            'lunes',
            'martes',
            'miércoles',
            'jueves',
            'viernes',
            'sábado',
          ],
        );
      },
    );
  });
}