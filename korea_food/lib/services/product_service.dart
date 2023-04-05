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

  // Future<bool> updateTable(Table pet) async {
  //   try {
  //     final url = Uri.parse('$databaseUrl/products/${pet.id}.json?auth=$token');
  //     final response = await http.patch(
  //       url,
  //       body: json.encode(pet.toJson()),
  //     );

  //     if (response.statusCode != 200) {
  //       throw Exception(json.decode(response.body)['error']);
  //     }

  //     return true;
  //   } catch (error) {
  //     print(error);
  //     return false;
  //   }
  // }

}
