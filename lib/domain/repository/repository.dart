import 'package:dartz/dartz.dart';
import 'package:newtest/data/network/failure.dart';
import 'package:newtest/data/network/requests.dart';
import 'package:newtest/domain/models/models.dart';

abstract class Repository {
 Future <Either<Failure,Authentication>> login(LoginRequest loginRequest);
}
