import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:textract/core/constants/app_constants.dart';
import 'package:textract/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:textract/core/models/user_model.dart';

abstract class ProfileDataSource {
  Future<UserModel> getUserData();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore firestore;
  final SecureStorageHelper secureStorageHelper;
  final FirebaseAuth auth;
  ProfileDataSourceImpl({
    required this.firestore,
    required this.secureStorageHelper,
    required this.auth,
  });
  @override
  Future<UserModel> getUserData() async {
    final userSession = await secureStorageHelper.getData(
      key: AppConstants.userSession,
    );
    if (userSession != null) {
      final userData = jsonDecode(userSession);
      return UserModel.fromJson(userData);
    } else {
      final response = await firestore
          .collection(AppConstants.usersCollectionName)
          .doc(auth.currentUser!.uid)
          .get();
      return UserModel.fromJson(response.data()!);
    }
  }
}
