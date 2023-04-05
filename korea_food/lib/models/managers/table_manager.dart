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

  // Future<void> updateTable(Table table) async {
  //   final index = _tables.indexWhere((item) => item.id == table.id);
  //   if (index >= 0) {
  //     if (await _tablesService.updateTable(table)) {
  //       _tables[index] = table;
  //       notifyListeners();
  //     }
  //   }
  // }

  List<TableModel> get tables {
    return [..._tables];
  }
}
