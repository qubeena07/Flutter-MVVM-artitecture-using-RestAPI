import 'package:mvvm_project/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? messgae;

  ApiResponse(this.data, this.messgae, this.status);
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed() : status = Status.COMPLETED;
  ApiResponse.error() : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message: $messgae \n Data:$data";
  }
}
