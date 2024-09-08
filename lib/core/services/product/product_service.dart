import 'dart:convert';

import 'package:klontongan/core/utils/api_url.dart';
import 'package:klontongan/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return List<ProductModel>.from(jsonDecode(response.body).map(
          (products) => ProductModel.fromJson(products),
        )).toList();
      }

      throw Exception(jsonDecode(response.body)['message']);
    } catch (e) {
      print('Error in Get Products: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
