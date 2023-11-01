import '../repositories/image_repository.dart';

class ImagePrompt {
  ImagePrompt({required this.text});

  final String text;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  bool get isLoaded => _imageUrl != null;

  Future<void> loadImage() async {
    try {
      if (_imageUrl == null) {
        final imageRepository = ImageRepository();
        _imageUrl = await imageRepository.fetchImageUrl(text);
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
