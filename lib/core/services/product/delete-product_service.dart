import 'dart:convert';

import 'package:klontongan/core/utils/api_url.dart';
import 'package:http/http.dart' as http;

class DeleteProductService {
  Future<bool> deleteProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/products/$id'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print('Error in Delete Product: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
