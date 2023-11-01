import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/image_prompt.dart';

class PromptImage extends StatelessWidget {
  const PromptImage({
    Key? key,
    required this.loadImageFuture,
    required this.prompt,
    this.onTryAgain,
  }) : super(key: key);

  final Future<void> loadImageFuture;
  final ImagePrompt prompt;
  final void Function()? onTryAgain;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 256,
      child: prompt.isLoaded
          ? FadeInImage.memoryNetwork(
              fadeInDuration: const Duration(milliseconds: 300),
              placeholder: kTransparentImage,
              image: prompt.imageUrl!,
              width: 256,
              fit: BoxFit.cover,
            )
          : FutureBuilder(
              future: loadImageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.error.toString(),
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: onTryAgain,
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  );
                }
                return FadeInImage.memoryNetwork(
                  fadeInDuration: const Duration(milliseconds: 300),
                  placeholder: kTransparentImage,
                  image: prompt.imageUrl!,
                  width: 256,
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }
}
