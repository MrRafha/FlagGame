import 'package:flutter/material.dart';

class CountryLabel extends StatelessWidget {
  const CountryLabel({super.key, required this.name, required this.visible});

  final String name;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Text(name),
    );
  }
}
