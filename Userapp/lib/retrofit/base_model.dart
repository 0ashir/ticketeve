import 'package:eventright_pro_user/retrofit/server_error.dart';

/// This class is used to handle the response from the api
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
