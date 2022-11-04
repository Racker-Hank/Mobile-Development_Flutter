// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traveloka/main.dart' as app;

void main() {
  testWidgets('test sign in', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // print("All states: ");
    // for (var s in tester.allStates) {
    //   print(s);
    // }

    // setup
    final Finder emailTextField = find.byIcon(Icons.email_rounded);
    final Finder passwordTextField = find.byIcon(Icons.vpn_key_rounded);
    final Finder switchToSignUp = find.byElementType(TextButton);

    // test
    expect(emailTextField, findsOneWidget);
    expect(passwordTextField, findsOneWidget);
    switchToSignUp.hitTestable();
  });
}
