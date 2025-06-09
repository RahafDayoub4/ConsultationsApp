import 'package:dio/dio.dart';
import 'package:newtest/app/constants.dart';
import 'package:newtest/data/responses/responses.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/costumer/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("passowrd") String passowrd,
  );
  
}
