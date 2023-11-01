import 'package:flutter/material.dart';

import '../models/image_prompt.dart';

class PromptsLeftText extends StatelessWidget {
  const PromptsLeftText({
    Key? key,
    required this.loadImageFuture,
    required this.prompts,
  }) : super(key: key);

  final Future<void> loadImageFuture;
  final List<ImagePrompt> prompts;

  int get promptsLeft {
    final processedCount =
        prompts.where((imgPrompt) => imgPrompt.isLoaded).length;
    return prompts.length - processedCount;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FutureBuilder(
      future: loadImageFuture,
      builder: (context, snapshot) {
        return Text.rich(
          TextSpan(
            text: 'Prompts left: ',
            style: textTheme.bodyLarge,
            children: [
              TextSpan(
                text: promptsLeft.toString(),
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
