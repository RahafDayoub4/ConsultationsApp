import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected; 

}

class NetworInfImpl implements NetworkInfo{

  final InternetConnectionChecker internetConnectionChecker;
  NetworInfImpl(this.internetConnectionChecker);
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;

}