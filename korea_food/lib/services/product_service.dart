import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:korea_food/config.dart';
import 'package:korea_food/models/product_model.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final List<Product> products = [];
    try {
      final productsUrl = Uri.http(Url, "/api/menu/QLTD");

      final response = await http.get(productsUrl);
      final productsMap = json.decode(response.body);

      if (response.statusCode != 200) {
        print(productsMap['error']);
        return products;
      }

      productsMap.forEach((product) {
        products.add(
          Product.fromJson(product),
        );
      });
      print(products);
      return products;
    } catch (error) {
      print(error);
      return products;
    }
  }

  Future<bool> updateProduct(List<Product> product) async {
    try {
      final productsUrl = Uri.http(Url, "/api/menu/QLTD");
      final response = await http.put(
        productsUrl,
        body: json.encode({'danh_sach_mon_an': product}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
