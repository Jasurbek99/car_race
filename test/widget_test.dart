import 'package:flutter_test/flutter_test.dart';

import 'package:car_race/main.dart';

void main() {
  testWidgets('Car Race app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CarRaceApp());
    expect(find.text('TAP TO START'), findsOneWidget);
  });
}
