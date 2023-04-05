import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:korea_food/models/user_model.dart';
import 'package:korea_food/services/user_service.dart';

class UserManager with ChangeNotifier {
  late User _user;

  final UsersService _usersService;

  UserManager() : _usersService = UsersService();

  Future<void> fetchUser() async {
    _user = (await _usersService.fetchUser(_user.id))!;
    notifyListeners();
  }

  Future<Map> changePassword(String oldPassword,String newPassword) async {
    return await _usersService.changePassword(oldPassword, newPassword,_user.id);
  }

  setUser(User user) {
    _user = user;
  }

  Future<void> updateUser(User user, File? img) async {
    if (await _usersService.updateUser(user, img)) {
      _user = user;
      notifyListeners();
    }
  }

  User get user {
    return _user;
  }
}
