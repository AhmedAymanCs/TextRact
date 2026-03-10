import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeDataSource {
  Future<XFile?> pickImage(ImageSource source);
  Future<String> extractText(InputImage file);
}

class HomeDataSourceImpl implements HomeDataSource {
  @override
  Future<String> extractText(InputImage file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognized = await textRecognizer.processImage(file);
    return recognized.text;
  }

  @override
  Future<XFile?> pickImage(ImageSource source) async {
    return await ImagePicker().pickImage(source: source);
  }
}
