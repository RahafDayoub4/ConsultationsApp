import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newtest/data/data_source/remote_data_source.dart';
import 'package:newtest/data/mapper/mapper.dart';
import 'package:newtest/data/network/failure.dart';
import 'package:newtest/data/network/network_info.dart';
import 'package:newtest/data/network/requests.dart';
import 'package:newtest/domain/models/models.dart';
import 'package:newtest/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  RepositoryImpl(this.remoteDataSource, this.networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
    LoginRequest loginRequest,
  ) async {
    if (await networkInfo.isConnected) {
      //its connected to net , call api
      final response = await remoteDataSource.login(loginRequest);

      if (response.status == 0) {
        //succses
        return Right(response.toDomain());
      } else {
        return Left(Failure(response.status!, response.message!));
      }
    } else {
      return Left(Failure(501, "no internet connection"));
    }
  }
}
