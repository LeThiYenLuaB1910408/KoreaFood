import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:korea_food/config.dart';
import 'package:korea_food/models/user_model.dart';
import 'package:path/path.dart' as p;

class UsersService {
  Future<User?> fetchUser(id) async {
    User? user;
    try {
      final userUrl = Uri.http(Url, "/api/users/Profile/$id");

      final response = await http.get(userUrl);
      final userMap = json.decode(response.body);
      if (response.statusCode != 200) {
        // print(usersMap['error']);
        return user;
      }

      user = User.fromJson(userMap);
      return user;
    } catch (error) {
      print(error);
      return user;
    }
  }

  Future changePassword(String oldPassword, String newPassword, id) async {
    try {
      final url = Uri.http(Url, "/api/users//Profile/Password/$id");
      final response = await http.put(
        url,
        body: json.encode({
          'old': oldPassword,
          'new': newPassword,
        }),
        headers: {"Content-Type": "application/json"},
      );
      final responseJson = json.decode(response.body);
      if (responseJson['error'] != null) {}
      return responseJson;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<bool> updateUser(User user, File? img) async {
    try {
      final userUrl = Uri.http(Url, "/api/users/QLNV/${user.id}");
      final response = await http.put(
        userUrl,
        body: json.encode(user.toJson()),
        headers: {"Content-Type": "application/json"},
      );
      if (img != null) {
        final avarUrl = Uri.http(Url, "/api/users/Profile/${user.id}");
        var request = http.MultipartRequest('PUT', avarUrl);
        final headers = {"Content-type": "multipart/form-data"};
        request.headers.addAll(headers);
        request.files.add(http.MultipartFile(
            'file', img.readAsBytes().asStream(), img.lengthSync(),
            filename: img.path.split("/").last));

        await http.MultipartFile.fromPath(
          'file',
          img.path,
          filename: p.basename(img.path),
        );

        var res = await request.send();
      }
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
