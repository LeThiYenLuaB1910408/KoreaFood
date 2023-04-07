import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:korea_food/config.dart';
import 'package:korea_food/models/bill_model.dart';

class BillsService {
  Future<List<Bill>> fetchBills(id) async {
    final List<Bill> bills = [];
    try {
      final billsUrl = Uri.http(Url, "/api/bill/LSHD/$id");

      final response = await http.get(billsUrl);
      final billsMap = json.decode(response.body);

      if (response.statusCode != 200) {
        print(billsMap['error']);
        return bills;
      }

      billsMap.forEach((bill) {
        bills.add(
          Bill.fromJson(bill),
        );
      });
      return bills;
    } catch (error) {
      print(error);
      return bills;
    }
  }
}
