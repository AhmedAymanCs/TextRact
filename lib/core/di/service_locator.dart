import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:textract/core/database/local/secure_storage/secure_storage_helper.dart';
import 'package:textract/features/auth/data/data_source/auth_data_source.dart';
import 'package:textract/features/auth/data/repository/auth_repository.dart';
import 'package:textract/features/history/data/data_source/data_source.dart';
import 'package:textract/features/history/data/repository/repo.dart';
import 'package:textract/features/home/data/data_source/data_source.dart';
import 'package:textract/features/home/data/repository/repo.dart';
import 'package:textract/features/profile/data/data_source/data_source.dart';
import 'package:textract/features/profile/data/repository/repo.dart';

final getIt = GetIt.instance;

void intiSetupLocator() {
  _setupSecureStorageServiceLocator();
  _setupAuthRepositoryLocator();
  _setupFirestoreServiceLocator();
  _setupHomeRepositoryLocator();
  _setupHistoryRepositoryLocator();
  _setupSupabaseServiceLocator();
  _setupProfileRepositoryLocator();
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
    () => HomeDataSourceImpl(getIt<FirebaseFirestore>(), getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeDataSource>()),
  );
}

void _setupHistoryRepositoryLocator() {
  getIt.registerLazySingleton<HistoryDataSource>(
    () => HistoryDataSourceImpl(
      getIt<FirebaseFirestore>(),
      getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(getIt<HistoryDataSource>()),
  );
}

Future<void> _setupSupabaseServiceLocator() async {
  String url = dotenv.env['SUPABASE_URL'] ?? '';
  String apiKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  await Supabase.initialize(url: url, anonKey: apiKey);

  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}

void _setupProfileRepositoryLocator() {
  getIt.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSourceImpl(
      firestore: getIt<FirebaseFirestore>(),
      secureStorageHelper: getIt<SecureStorageHelper>(),
      auth: getIt<FirebaseAuth>(),
    ),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileDataSource>()),
  );
}
