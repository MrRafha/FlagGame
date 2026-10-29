import 'package:flutter_test/flutter_test.dart';

import 'package:flag_game/app.dart';

void main() {
  testWidgets('menu inicial apresenta ações principais', (tester) async {
    await tester.pumpWidget(const FlagGameApp());

    expect(find.text('flag game.'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
    expect(find.text('Modo aleatório'), findsOneWidget);
    expect(find.text('Ranking local'), findsOneWidget);
  });
}
