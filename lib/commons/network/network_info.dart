import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  // final _connect = Future.value(true);
  Future<bool> isConnected() /* => Future.value(true)*/;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> isConnected() => connectionChecker.hasConnection;
}
