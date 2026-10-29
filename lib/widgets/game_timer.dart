import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget {
  const GameTimer({super.key, required this.remaining});

  final Duration remaining;

  @override
  Widget build(BuildContext context) {
    final seconds = remaining.inSeconds;
    return Text(
      '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}',
    );
  }
}
