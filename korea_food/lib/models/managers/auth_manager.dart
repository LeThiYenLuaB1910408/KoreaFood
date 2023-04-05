import 'dart:async';

import 'package:flutter/foundation.dart';
import '../../services/auth_service.dart';

class AuthManager with ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<Map> login(String username, String password) async {
    return await _authService.login(username, password);
  }
  
}
