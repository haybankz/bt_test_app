import 'package:equatable/equatable.dart';

class NetworkResponse<T> extends Equatable {
  T? data;
  Status status;
  String? message;

  NetworkResponse.success(this.data) : status = Status.success;

  NetworkResponse.error(this.message) : status = Status.error;

  NetworkResponse.loading(this.message) : status = Status.loading;

  @override
  // TODO: implement props
  List<Object?> get props => [data, status, message];
}

enum Status { success, error, loading }
