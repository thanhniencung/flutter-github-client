import 'package:dio/dio.dart';
import 'package:flutter_app_github_trending/shared/spref.dart';

class GithubService {
  static BaseOptions _options = new BaseOptions(
    baseUrl: "http://localhost:3000",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static Dio _dio = Dio(_options);

  GithubService._internal() {
    //_dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options myOption) async {
      var token = await SPref.instance.get("token");
      if (token != null) {
        print("=================");
        print(token);
        print("=================");
        myOption.headers["Authorization"] = "Bearer " + token;
      }

      return myOption;
    }));
  }
  static final GithubService instance = GithubService._internal();

  Dio get dio => _dio;
}
