import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('test sign in', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      print("All states: ");
      for (var s in tester.allStates) {
        print(s);
      }

      // setup
      final Finder emailTextField = find.byIcon(Icons.email_rounded);
      final Finder passwordTextField = find.byIcon(Icons.vpn_key_rounded);
      final Finder switchToSignUp = find.byElementType(TextButton);

      // test
      expect(emailTextField, findsOneWidget);
      expect(passwordTextField, findsOneWidget);
      switchToSignUp.hitTestable();
    });
  });
}
