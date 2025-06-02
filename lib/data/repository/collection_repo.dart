import 'dart:convert';
import 'package:flutter_pagination/data/model/collection_model.dart';
import 'package:http/http.dart' as http;

class CollectionRepository {
  static Future<List<Products>> fetchProductDetails({
    int page = 1,
    int limit = 10,
  }) async {
    var response;
    try {
      final String baseUrl = 'https://dummyjson.com';
      response = await http.get(
        Uri.parse('$baseUrl/products?limit=$limit&skip=${(page - 1) * limit}'),
      );
    } catch (e) {
      print('Error::$e');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsJson = data['products'];
      final List<Products> products =
          productsJson
              .map((item) => Products.fromJson(item as Map<String, dynamic>))
              .toList();

      return products;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
