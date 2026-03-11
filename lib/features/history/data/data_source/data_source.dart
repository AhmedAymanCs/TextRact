import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:textract/core/constants/app_constants.dart';
import 'package:textract/core/models/text_form_model.dart';

abstract class HistoryDataSource {
  Future<List<TextFormModel>> getTextFromDatabase();
  Future<void> deleteTextFromDatabase(String id);
}

class HistoryDataSourceImpl implements HistoryDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  HistoryDataSourceImpl(this._firestore, this._auth);
  @override
  @override
  Future<List<TextFormModel>> getTextFromDatabase() async {
    final response = await _firestore
        .collection(AppConstants.usersCollectionName)
        .doc(_auth.currentUser!.uid)
        .collection(AppConstants.databaseCollectionName)
        .get();
    return response.docs.map((e) => TextFormModel.fromjson(e.data())).toList();
  }

  @override
  Future<void> deleteTextFromDatabase(String id) async {
    await _firestore
        .collection(AppConstants.usersCollectionName)
        .doc(_auth.currentUser!.uid)
        .collection(AppConstants.databaseCollectionName)
        .doc(id)
        .delete();
  }
}
