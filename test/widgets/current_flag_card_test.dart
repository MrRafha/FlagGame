import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flag_game/widgets/current_flag_card.dart';

void main() {
  testWidgets('bandeira atual é disponibilizada como Draggable', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CurrentFlagCard(
          flagAsset: 'assets/flags/br.svg',
          countryCode: 'BR',
        ),
      ),
    );

    expect(find.byType(Draggable<String>), findsOneWidget);
  });
}
