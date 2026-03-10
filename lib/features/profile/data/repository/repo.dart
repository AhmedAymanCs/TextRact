import 'package:dartz/dartz.dart';
import 'package:textract/core/models/user_model.dart';
import 'package:textract/core/utils/typedef.dart';
import 'package:textract/features/profile/data/data_source/data_source.dart';
import 'package:textract/features/profile/data/models/update_model.dart';

abstract class ProfileRepository {
  ServerResponse<UserModel> getUserData();
  ServerResponse<Unit> updateUserData(UpdateModel data);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;
  ProfileRepositoryImpl(this._dataSource);
  @override
  ServerResponse<UserModel> getUserData() async {
    try {
      final response = await _dataSource.getUserData();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ServerResponse<Unit> updateUserData(UpdateModel data) async {
    try {
      await _dataSource.updateUserData(data);
      return Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
