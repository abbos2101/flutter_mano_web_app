import 'package:dio/dio.dart';
import '../../../data/model/response.dart';

RouteService routeService = RouteService();

class RouteService {
  static final String baseUrl = "http://185.16.40.113:8080/api/";
  final Dio _dio = Dio();

  Future<ResponseModel> request({
    String url,
    String method = 'GET',
    dynamic data,
    Map<String, dynamic> headers,
    bool isChecked = true,
    int timeOut = 60000,
  }) async {
    if (!isChecked) return ResponseModel.empty();
    try {
      Response response = await _dio.request(
        "$baseUrl$url",
        options: Options(
          headers: headers,
          method: method,
          sendTimeout: timeOut,
          receiveTimeout: timeOut,
          validateStatus: (status) => status == 200,
        ),
        data: data,
      );

      // print("NETWORK");
      // print("$baseUrl$url");
      // print(response.statusCode);
      // print(response.statusMessage);
      // print(response.data);

      return _getResponseModel(response);
    } on DioError catch (e) {
      return ResponseModel.fail(message: e.response.data);
    } catch (e) {
      return ResponseModel.fail(message: e);
    }
  }

  ResponseModel _getResponseModel(Response response) {
    if (response != null && response.statusCode == 200 && response.data != null)
      return ResponseModel.fromJson(response.data);
    return ResponseModel.empty();
  }
}
