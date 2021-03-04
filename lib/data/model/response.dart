class ResponseModel {
  final String message;
  final bool success;
  final dynamic object;

  const ResponseModel({this.message, this.success, this.object});

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        message: json['message'],
        success: json['success'],
        object: json['object'],
      );

  factory ResponseModel.empty() => ResponseModel(success: false);

  factory ResponseModel.fail({String message}) =>
      ResponseModel(success: false, message: message);

  static void onException(ResponseModel model, String message) {
    if (model.message == 'Access denied') throw Exception('Access denied');
    if (model.success == false) throw Exception('$message');
  }
}
