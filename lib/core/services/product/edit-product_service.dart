import 'dart:convert';

import 'package:klontongan/core/utils/api_url.dart';
import 'package:klontongan/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class EditProductService {
  Future<ProductModel> editProduct(ProductModel data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/products/${data.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return ProductModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print('Error in Edit Product: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
