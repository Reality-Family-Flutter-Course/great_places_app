import 'dart:convert';

import 'package:http/http.dart' as http;

const GEOCODE_API = "a38a98ec-4021-4319-9a52-e53c8a87e438";

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://static-maps.yandex.ru/1.x/?ll=$longitude,$latitude&size=450,450&z=13&l=map&pt=$longitude,$latitude,comma';
  }

  static Future<String> getAddressFromGeoPoint({
    required double latitude,
    required double longitude,
  }) async {
    String requestUrl =
        "https://geocode-maps.yandex.ru/1.x/?format=json&apikey=$GEOCODE_API&geocode=$longitude,$latitude";

    var response = await http.get(
      Uri.parse(requestUrl),
    );

    String? responseAddress = jsonDecode(response.body)["response"]
            ["GeoObjectCollection"]["featureMember"][0]["GeoObject"]
        ["metaDataProperty"]["GeocoderMetaData"]["text"];
    return responseAddress ?? "";
  }
}
