import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:korea_food/config.dart';
import 'package:korea_food/models/table_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

class TablesService {
  late Socket socket;

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

  Future<bool> updateTable(String id, String trang_thai_ban_an) async {
    try {
      final tablesUrl = Uri.http(Url, "/api/table/QLBA/$id");

      final response = await http.put(
        tablesUrl,
        body: json.encode({'trang_thai_ban_an': trang_thai_ban_an}),
        headers: {"Content-Type": "application/json"},
      );
      socket = io(socketUrl, <String, dynamic>{
        'transports': ['websocket'],
      });
      socket.connect();
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.emit('updateOrder');
      socket.close();
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
