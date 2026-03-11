import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textract/core/constants/app_constants.dart';
import 'package:textract/core/models/text_form_model.dart';

abstract class HomeDataSource {
  //local
  Future<XFile?> pickImage(ImageSource source);
  Future<String> extractText(InputImage file);
  //remote
  Future<void> saveTextInDatabase(TextFormModel text);
}

class HomeDataSourceImpl implements HomeDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  HomeDataSourceImpl(this._firestore, this._auth);

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

  @override
  Future<void> saveTextInDatabase(TextFormModel text) async {
    await _firestore
        .collection(AppConstants.usersCollectionName)
        .doc(_auth.currentUser!.uid)
        .collection(AppConstants.databaseCollectionName)
        .doc(text.id)
        .set(text.toJson());
  }
}
