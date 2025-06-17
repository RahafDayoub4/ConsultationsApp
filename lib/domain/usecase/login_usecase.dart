import 'package:dartz/dartz.dart';
import 'package:newtest/data/network/failure.dart';
import 'package:newtest/data/network/requests.dart';
import 'package:newtest/domain/models/models.dart';
import 'package:newtest/domain/repository/repository.dart';
import 'package:newtest/domain/usecase/base_usecase.dart';

class LoginUsecase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;

  LoginUsecase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
    LoginUseCaseInput input,
  ) async {
   return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
