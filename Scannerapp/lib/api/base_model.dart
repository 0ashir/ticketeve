import 'package:event_right_scanner/api/server_error.dart';

class BaseModel<T> {
  late ServerError error;
  T? data;

  setException(ServerError error) {
    this.error = error;
  }

  setData(T data) {
    this.data = data;
  }
}
