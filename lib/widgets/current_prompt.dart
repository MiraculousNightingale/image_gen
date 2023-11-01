import 'package:flutter/material.dart';

class CurrentPromptText extends StatelessWidget {
  const CurrentPromptText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Current prompt:',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}
