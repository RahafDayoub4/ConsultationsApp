import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newtest/data/data_source/remote_data_source.dart';
import 'package:newtest/data/network/app_api.dart';
import 'package:newtest/data/network/dio_factory.dart';
import 'package:newtest/data/network/network_info.dart';
import 'package:newtest/data/repository/repository_implementer.dart';
import 'package:newtest/domain/repository/repository.dart';
import 'package:newtest/domain/usecase/login_usecase.dart';
import 'package:newtest/presentation/login/viewmodel/login_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module ,its a module where we put all genric dependecies

  //network info instance
  // instance.registerLazySingleton<NetworkInfo>(
  //   () => NetworInfImpl(InternetConnectionChecker()),
  // );

  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //app service clien
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImp(instance<AppServiceClient>()),
  );

  //repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(instance(), instance()),
  );
}

initLoinModule() {
  if (!GetIt.I.isRegistered<LoginUsecase>()) {
    instance.registerFactory<LoginUsecase>(() => LoginUsecase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
