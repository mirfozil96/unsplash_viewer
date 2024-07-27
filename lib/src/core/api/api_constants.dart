enum ResponseStatus {
  success,
  failure,
  networkError,
}

final class ApiConstants {
  // baseUrl
  static const String baseUrl = "api.unsplash.com";

  // version
  // static const version = '/api/v1';

  // apis
  static const String apiGetAllImages = "/photos/";

  // headers
  static Map<String, String> headers = <String, String>{
    "Content-Type": "application/json",
  };

  /// params

  static Map<String, String> paramsEmpty() => const <String, String>{};

  static Map<String, String> paramsGetAllImages({required int page}) =>
      <String, String>{
        "client_id": "3I2xJ8XoEsXMec9waq8WhYc15f6Z87rodgIVuGhtr4Q",
        "page": page.toString(),
        "per_page": "10",
      };

  /// body

  static Map<String, dynamic> bodyEmpty() => const <String, dynamic>{};
}
