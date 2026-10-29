import 'package:flutter/material.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({super.key, required this.score, required this.progress});

  final int score;
  final String progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text('Pontos: $score'), Text(progress)],
    );
  }
}
