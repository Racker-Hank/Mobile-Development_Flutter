import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:traveloka/components/button.dart';
import 'package:traveloka/repositories/hotel_data.dart';
import 'package:traveloka/view/search/search_view.dart';

import 'package:traveloka/main.dart' as app;

class MockHotelFirebase extends Mock implements HotelFirebase {}

void main() {
  // late HotelFirebase sut;
  late MockHotelFirebase mockHotelFirebase;
  // final MySearchPageState mySearchPageState = test

  setUp(() {
    mockHotelFirebase = MockHotelFirebase();
  });

  group('app', () {
    testWidgets('main', (tester) async {
      app.main();
      await tester.pumpAndSettle();
    });

    final Finder emailTextField = find.byType(TextField).at(0);
    final Finder passwordTextField = find.byType(TextField).at(1);
    final Finder signInButton = find.byType(Button).at(0);

    testWidgets('test sign in', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // setup
      // final Finder emailTextField = find.byIcon(Icons.email_rounded);
      // final Finder passwordTextField = find.byIcon(Icons.vpn_key_rounded);
      // final Finder signInButton = find.byIcon(Icons.flight_takeoff_rounded);

      // test
      // await tester.enterText(emailTextField, 'test2@gmail.com');
      // await tester.enterText(passwordTextField, '654321');
      // tester.tap(signInButton);

      expect(emailTextField, findsOneWidget);
      expect(passwordTextField, findsOneWidget);
      expect(signInButton, findsOneWidget);
    });

    testWidgets('test sign in with filled form', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // test
      await tester.enterText(emailTextField, '20020141@vnu.edu.vn');
      await tester.enterText(passwordTextField, '1234567890');
      await tester.tap(signInButton);
      expect(emailTextField, findsNothing);
      // expect(passwordTextField, findsOneWidget);
      // expect(signInButton, findsOneWidget);
    });

    testWidgets('my search page test', (tester) async {
      const Key mySearchPageKey = Key('mySearchPageKey');
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: MySearchPage(),
        ),
      );
      const MySearchPage mySearchPage = MySearchPage(key: mySearchPageKey);
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle(Duration(seconds: 5));
      // final State<MySearchPage> mySearchPageState =
      //     tester.state(find.byType(MySearchPage));
      // expect(mySearchPageState.widget, equals(mySearchPage));
      final StatefulElement innerElement =
          tester.element(find.byKey(mySearchPageKey));
      final State<MySearchPage> innerElementState =
          innerElement.state as State<MySearchPage>;
      expect(innerElementState.widget, equals(mySearchPage));
    });
  });
}
