import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:textract/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:textract/features/auth/data/data_source/auth_data_source.dart';
import 'package:textract/features/auth/data/repository/auth_repository.dart';
import 'package:textract/features/home/data/data_source/data_source.dart';
import 'package:textract/features/home/data/repository/repo.dart';

final getIt = GetIt.instance;

void intiSetupLocator() {
  _setupSecureStorageServiceLocator();
  _setupAuthRepositoryLocator();
  _setupFirestoreServiceLocator();
  _setupHomeRepositoryLocator();
}

void _setupSecureStorageServiceLocator() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
  );
  getIt.registerLazySingleton<SecureStorageHelper>(
    () => SecureStorageHelper(getIt<FlutterSecureStorage>()),
  );
}

void _setupAuthRepositoryLocator() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: getIt<AuthRemoteDataSource>(),
      firestore: getIt<FirebaseFirestore>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
    ),
  );
}

void _setupFirestoreServiceLocator() {
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
}

void _setupHomeRepositoryLocator() {
  getIt.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImpl(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeDataSource>()),
  );
}
