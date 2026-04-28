import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:roux_cube/main.dart';

void main() {
  testWidgets('Roux trainer shell renders the embedded trainer route', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      RouxTrainerApp(trainerViewBuilder: (_) => const TestTrainerView()),
    );

    expect(find.text('Roux Bridge Trainer'), findsOneWidget);
    expect(find.text('FB / SB practice'), findsOneWidget);
    expect(find.byType(TestTrainerView), findsOneWidget);
  });
}

class TestTrainerView extends StatelessWidget {
  const TestTrainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('trainer web view');
  }
}
