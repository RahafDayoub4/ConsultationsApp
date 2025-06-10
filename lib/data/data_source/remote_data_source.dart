import 'package:newtest/data/network/app_api.dart';
import 'package:newtest/data/network/requests.dart';
import 'package:newtest/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final AppServiceClient appServiceClient;

  RemoteDataSourceImp(this.appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }
}
