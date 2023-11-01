import 'package:flutter/material.dart';

import '../models/image_prompt.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    Key? key,
    required this.loadImageFuture,
    required this.prompts,
    required this.currentIndex,
    this.onPrevious,
    this.onNext,
  }) : super(key: key);

  final Future<void> loadImageFuture;
  final List<ImagePrompt> prompts;
  final int currentIndex;
  final void Function()? onPrevious;
  final void Function()? onNext;

  ImagePrompt get currentPrompt => prompts[currentIndex];
  ImagePrompt get previousPrompt => prompts[currentIndex - 1];
  ImagePrompt get nextPrompt => prompts[currentIndex + 1];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadImageFuture,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;

        final canShowPrevious = !isLoading ||
            !snapshot.hasError &&
                currentPrompt.isLoaded &&
                previousPrompt.isLoaded;

        final canShowNext = !isLoading ||
            !snapshot.hasError && currentPrompt.isLoaded && nextPrompt.isLoaded;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (currentIndex > 0)
              ElevatedButton(
                onPressed: canShowPrevious ? onPrevious : null,
                child: const Text('Previous'),
              ),
            if (currentIndex < prompts.length - 1)
              ElevatedButton(
                onPressed: canShowNext ? onNext : null,
                child: const Text('Next'),
              ),
          ],
        );
      },
    );
  }
}
