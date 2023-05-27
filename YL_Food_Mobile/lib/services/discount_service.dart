import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:korea_food/config.dart';
import 'package:korea_food/models/discount_model.dart';

class DiscountService {
  Future<List<Discount>> fetchDiscounts() async {
    final List<Discount> discounts = [];
    try {
      final discountsUrl = Uri.http(Url, "/api/sale/QLKM");

      final response = await http.get(discountsUrl);
      final discountsMap = json.decode(response.body);

      if (response.statusCode != 200) {
        print(discountsMap['error']);
        return discounts;
      }
      print(discountsMap);

      discountsMap.forEach((discount) {
        discounts.add(
          Discount.fromJson(discount),
        );
      });
      print(discounts);
      return discounts;
    } catch (error) {
      print(error);
      return discounts;
    }
  }

  // Future<bool> updateTable(Table pet) async {
  //   try {
  //     final url = Uri.parse('$databaseUrl/discounts/${pet.id}.json?auth=$token');
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
