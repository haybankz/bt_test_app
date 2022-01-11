class NetworkResponse<T> {
  T? data;
  Status status;
  String? message;

  NetworkResponse.success(this.data) : status = Status.success;

  NetworkResponse.error(this.message) : status = Status.error;

  NetworkResponse.loading(this.message) : status = Status.loading;
}

enum Status { success, error, loading }
