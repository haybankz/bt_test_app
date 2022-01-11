class NetworkResponse<T> {
  T? data;
  State state;
  String? message;

  NetworkResponse.success(this.data) : state = State.success;

  NetworkResponse.error(this.message) : state = State.error;

  NetworkResponse.loading(this.message) : state = State.loading;

  NetworkResponse.initial() : state = State.initial;
}

enum State { initial, success, error, loading }
