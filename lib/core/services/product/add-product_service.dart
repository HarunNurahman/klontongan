import 'dart:convert';

import 'package:klontongan/core/utils/api_url.dart';
import 'package:klontongan/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class AddProductService {
  Future<ProductModel> addProduct(ProductModel data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      return ProductModel.fromJson(jsonDecode(response.body)['data']);
    } catch (e) {
      print('Error in Add New Product: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
