import 'package:flutter/material.dart';

class AnswerFeedback extends StatelessWidget {
  const AnswerFeedback({
    super.key,
    required this.message,
    required this.isCorrect,
  });

  final String message;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(
        color: isCorrect ? Colors.green.shade800 : Colors.red.shade800,
      ),
    );
  }
}
