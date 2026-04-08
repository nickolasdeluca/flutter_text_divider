import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_divider/flutter_text_divider.dart';

void main() {
  // Wraps the widget under test in a minimal Material app so that Theme
  // lookups inside TextDivider resolve without errors.
  Widget wrap(Widget child, {Axis? scrollAxis}) {
    return MaterialApp(
      home: Scaffold(
        body: scrollAxis == Axis.vertical
            ? SizedBox(height: 300, child: child)
            : child,
      ),
    );
  }

  // Wraps the widget inside an unbounded-constraint parent for the given axis.
  Widget wrapUnbounded(Widget child, {required Axis axis}) {
    return MaterialApp(
      home: Scaffold(
        body: axis == Axis.vertical
            ? SingleChildScrollView(child: child)
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: child,
              ),
      ),
    );
  }

  group('TextDivider - horizontal (default)', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(wrap(const TextDivider(text: 'or')));
      expect(tester.takeException(), isNull);
    });

    testWidgets('displays the provided text', (tester) async {
      await tester.pumpWidget(wrap(const TextDivider(text: 'or')));
      expect(find.text('or'), findsOneWidget);
    });

    testWidgets('uses a Row as its root', (tester) async {
      await tester.pumpWidget(wrap(const TextDivider(text: 'or')));
      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('renders two Divider widgets', (tester) async {
      await tester.pumpWidget(wrap(const TextDivider(text: 'or')));
      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('accepts custom textStyle', (tester) async {
      const style = TextStyle(fontSize: 20, color: Colors.red);
      await tester.pumpWidget(
        wrap(const TextDivider(text: 'or', textStyle: style)),
      );
      final text = tester.widget<Text>(find.text('or'));
      expect(text.style?.fontSize, 20);
      expect(text.style?.color, Colors.red);
    });

    testWidgets('accepts custom color without error', (tester) async {
      await tester.pumpWidget(
        wrap(const TextDivider(text: 'or', color: Colors.blue, thickness: 2.0)),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('accepts indent and endIndent', (tester) async {
      await tester.pumpWidget(
        wrap(const TextDivider(text: 'or', indent: 16.0, endIndent: 16.0)),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('survives unbounded width', (tester) async {
      await tester.pumpWidget(
        wrapUnbounded(const TextDivider(text: 'or'), axis: Axis.horizontal),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('or'), findsOneWidget);
    });
  });

  group('TextDivider - vertical', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(
        wrap(
          const TextDivider(text: 'or', axis: Axis.vertical),
          scrollAxis: Axis.vertical,
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('displays the provided text', (tester) async {
      await tester.pumpWidget(
        wrap(
          const TextDivider(text: 'or', axis: Axis.vertical),
          scrollAxis: Axis.vertical,
        ),
      );
      expect(find.text('or'), findsOneWidget);
    });

    testWidgets('uses a Column as its root', (tester) async {
      await tester.pumpWidget(
        wrap(
          const TextDivider(text: 'or', axis: Axis.vertical),
          scrollAxis: Axis.vertical,
        ),
      );
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('renders two VerticalDivider widgets', (tester) async {
      await tester.pumpWidget(
        wrap(
          const TextDivider(text: 'or', axis: Axis.vertical),
          scrollAxis: Axis.vertical,
        ),
      );
      expect(find.byType(VerticalDivider), findsNWidgets(2));
    });

    testWidgets('survives unbounded height', (tester) async {
      await tester.pumpWidget(
        wrapUnbounded(
          const TextDivider(text: 'or', axis: Axis.vertical),
          axis: Axis.vertical,
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('or'), findsOneWidget);
    });
  });

  group('TextDivider - height (horizontal)', () {
    testWidgets('wraps in a SizedBox with the given height', (tester) async {
      await tester.pumpWidget(
        wrap(const TextDivider(text: 'or', height: 48.0)),
      );

      final sizedBox = tester.widget<SizedBox>(
        find
            .descendant(
              of: find.byType(TextDivider),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(sizedBox.height, 48.0);
    });

    testWidgets('centres content vertically within the height', (tester) async {
      await tester.pumpWidget(
        wrap(const TextDivider(text: 'or', height: 80.0)),
      );

      expect(
        find.descendant(
          of: find.byType(SizedBox),
          matching: find.byType(Center),
        ),
        findsWidgets,
      );
    });

    testWidgets('renders without error when height is null', (tester) async {
      await tester.pumpWidget(wrap(const TextDivider(text: 'or')));
      expect(tester.takeException(), isNull);
    });
  });

  group('TextDivider - width (vertical)', () {
    testWidgets('wraps in a SizedBox with the given width', (tester) async {
      await tester.pumpWidget(
        wrap(
          const TextDivider(text: 'or', axis: Axis.vertical, width: 64.0),
          scrollAxis: Axis.vertical,
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find
            .descendant(
              of: find.byType(TextDivider),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(sizedBox.width, 64.0);
    });

    testWidgets('centres content horizontally within the width', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          const TextDivider(text: 'or', axis: Axis.vertical, width: 80.0),
          scrollAxis: Axis.vertical,
        ),
      );

      expect(
        find.descendant(
          of: find.byType(SizedBox),
          matching: find.byType(Center),
        ),
        findsWidgets,
      );
    });
  });

  group('TextDivider - assertions', () {
    test('throws when thickness <= 0', () {
      expect(() => TextDivider(text: 'or', thickness: 0), throwsAssertionError);
    });

    test('throws when gap is negative', () {
      expect(() => TextDivider(text: 'or', gap: -1), throwsAssertionError);
    });

    test('throws when indent is negative', () {
      expect(() => TextDivider(text: 'or', indent: -4), throwsAssertionError);
    });

    test('throws when endIndent is negative', () {
      expect(
        () => TextDivider(text: 'or', endIndent: -4),
        throwsAssertionError,
      );
    });

    test('throws when height is negative', () {
      expect(() => TextDivider(text: 'or', height: -1), throwsAssertionError);
    });

    test('throws when width is negative', () {
      expect(() => TextDivider(text: 'or', width: -1), throwsAssertionError);
    });

    test('throws when fallbackLineLength <= 0', () {
      expect(
        () => TextDivider(text: 'or', fallbackLineLength: 0),
        throwsAssertionError,
      );
    });
  });
}
