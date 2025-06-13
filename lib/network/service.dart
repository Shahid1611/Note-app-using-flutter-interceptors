class AppInterceptor extends Interceptor {
  final TokenRepository tokenRepository;

  AppInterceptor(this.tokenRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenRepository.getToken();
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newToken = await tokenRepository.refreshToken();
      err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
      final response = await Dio().fetch(err.requestOptions);
      return handler.resolve(response);
    }
    super.onError(err, handler);
  }
}
