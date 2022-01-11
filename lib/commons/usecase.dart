import 'package:bt_test_app/commons/export.dart';

abstract class UseCase<S, T> {
  Future<NetworkResponse<S>> call(T param);
}

///Needed for use cases that do not really need parameter
class NoParam {}
