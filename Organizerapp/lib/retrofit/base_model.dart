import 'package:eventright_organizer/retrofit/error_handler.dart';

class BaseModel<T> {
  late ErrorClass error;
  T? data;

  setException(ErrorClass error) {
    this.error = error;
  }

  setData(T data) {
    this.data = data;
  }
}
