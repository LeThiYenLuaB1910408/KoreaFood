import 'package:flutter/foundation.dart';
import 'package:korea_food/models/bill_model.dart';
import 'package:korea_food/services/bill_service.dart';

class BillsManager with ChangeNotifier {
  List<Bill> _bills = [];

  final BillsService _billsService;

  BillsManager() : _billsService = BillsService();

  Future<void> fetchBills(id) async {
    _bills = await _billsService.fetchBills(id);
    notifyListeners();
  }

  List<Bill> get bills {
    return [..._bills];
  }
}
