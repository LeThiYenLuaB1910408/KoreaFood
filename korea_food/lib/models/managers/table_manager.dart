import 'package:flutter/foundation.dart';
import 'package:korea_food/models/table_model.dart';
import 'package:korea_food/services/table_service.dart';

class TablesManager with ChangeNotifier {
  List<TableModel> _tables = [];

  final TablesService _tablesService;

  TablesManager() : _tablesService = TablesService();

  Future<void> fetchTables() async {
    _tables = await _tablesService.fetchTables();
    notifyListeners();
  }

  Future<void> updateTable(String id, String trang_thai_ban_an) async {
    await _tablesService.updateTable(id, trang_thai_ban_an);
    notifyListeners();
  }

  List<TableModel> get tables {
    return [..._tables];
  }
}
