import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Ensure Working converter", (WidgetTester tester) async {
    final title = find.byKey(ValueKey("title"));
    final price = find.byKey(ValueKey("price"));
    final discount = find.byKey(ValueKey("discount"));

    expect(title, findsOneWidget);
    await tester.tap(title);
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.enterText(title, "Hello");
    await tester.pumpAndSettle(Duration(seconds: 2));
    expect(price, findsOneWidget);
    await tester.tap(price);
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.enterText(price, "100");
    await tester.pumpAndSettle(Duration(seconds: 2));
    expect(discount, findsOneWidget);
    await tester.tap(discount);
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.enterText(discount, "10");
    await tester.pumpAndSettle(Duration(seconds: 2));
    expect(find.widgetWithText(Text, "90.0"), findsOneWidget);
  });
}
