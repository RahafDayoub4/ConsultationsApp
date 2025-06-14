import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newtest/data/data_source/remote_data_source.dart';
import 'package:newtest/data/mapper/mapper.dart';
import 'package:newtest/data/network/error_handler.dart';
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
      try {
        //its connected to net , call api
        final response = await remoteDataSource.login(loginRequest);

        if (response.status == AppInternalStatus.SUCCESS) {
          //succses
          return Right(response.toDomain());
        } else {
          return Left(Failure(AppInternalStatus.FAILURE, response.message ?? ResponseMesaage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERENT_CONNECTION.getFailure());
    }
  }
}
