import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import '../models/image_prompt.dart';
import '../widgets/control_buttons.dart';
import '../widgets/current_prompt.dart';
import '../widgets/prompt_image.dart';
import '../widgets/prompts_left_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _promptLimit = 5;
  int _currentIndex = 0;

  final List<ImagePrompt> _imagePrompts = [];
  late Future<void> _loadImageFuture;

  ImagePrompt get _currentPrompt => _imagePrompts[_currentIndex];

  @override
  void initState() {
    super.initState();

    final wordPairs = generateWordPairs(
      random: Random(),
    ).take(1 + _promptLimit); // initial prompt + the others

    for (final wordPair in wordPairs) {
      _imagePrompts.add(ImagePrompt(text: wordPair.join(' ')));
    }

    _loadImageFuture = _imagePrompts.first.loadImage();
  }

  void _onPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        --_currentIndex;
        if (!_currentPrompt.isLoaded) {
          _loadImageFuture = _currentPrompt.loadImage();
        }
      });
    }
  }

  void _onNext() {
    if (_currentIndex < _promptLimit) {
      setState(() {
        ++_currentIndex;
        if (!_currentPrompt.isLoaded) {
          _loadImageFuture = _currentPrompt.loadImage();
        }
      });
    }
  }

  void _onTryAgain() {
    setState(() {
      _loadImageFuture = _currentPrompt.loadImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PromptImage(
            loadImageFuture: _loadImageFuture,
            prompt: _currentPrompt,
            onTryAgain: _onTryAgain,
          ),
          CurrentPromptText(text: _currentPrompt.text),
          ControlButtons(
            loadImageFuture: _loadImageFuture,
            prompts: _imagePrompts,
            currentIndex: _currentIndex,
            onPrevious: _onPrevious,
            onNext: _onNext,
          ),
          PromptsLeftText(
            loadImageFuture: _loadImageFuture,
            prompts: _imagePrompts,
          ),
        ],
      ),
    );
  }
}
