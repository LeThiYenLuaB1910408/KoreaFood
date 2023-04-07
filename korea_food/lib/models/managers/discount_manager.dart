import 'package:flutter/foundation.dart';
import 'package:korea_food/models/discount_model.dart';
import 'package:korea_food/services/discount_service.dart';

class DiscountManager with ChangeNotifier {
  List<Discount> _discounts = [];

  final DiscountService _discountsService;

  DiscountManager() : _discountsService = DiscountService();

  Future<void> fetchDiscounts() async {
    _discounts = await _discountsService.fetchDiscounts();
    notifyListeners();
  }

  List<Discount> get discounts {
    return [..._discounts];
  }
}
