import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:korea_food/config.dart';
import 'package:korea_food/models/table_model.dart';

class TablesService {
  Future<List<TableModel>> fetchTables() async {
    final List<TableModel> tables = [];
    try {
      final tablesUrl = Uri.http(Url, "/api/table/QLBA");

      final response = await http.get(tablesUrl);
      final tablesMap = json.decode(response.body);

      if (response.statusCode != 200) {
        print(tablesMap['error']);
        return tables;
      }

      tablesMap.forEach((table) {
        tables.add(
          TableModel.fromJson({
            'id': table['_id'],
            'trang_thai_ban_an': table['trang_thai_ban_an'],
            'so_cho_ngoi': table['so_cho_ngoi'],
          }),
        );
      });
      return tables;
    } catch (error) {
      print(error);
      return tables;
    }
  }

  // Future<bool> updateTable(Table pet) async {
  //   try {
  //     final url = Uri.parse('$databaseUrl/tables/${pet.id}.json?auth=$token');
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
