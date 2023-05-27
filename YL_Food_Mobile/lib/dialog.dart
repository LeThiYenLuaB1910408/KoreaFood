import 'package:flutter/material.dart';
import 'package:korea_food/homepage.dart';
import 'package:korea_food/models/table_model.dart';
import 'package:korea_food/order.dart';
import 'package:korea_food/user.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text(
        'CẢNH BÁO',
        style: TextStyle(color: Colors.red),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Không',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text('Có',
              style: TextStyle(fontSize: 18, color: Colors.red)),
          onPressed: () {
            Navigator.of(ctx).pop(true);
          },
        ),
      ],
    ),
  );
}

Future<bool?> showMessageDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text("THÔNG BÁO", style: TextStyle(color: Colors.red)),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('OK', style: TextStyle(fontSize: 18)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    ),
  );
}

Future<bool?> showSuccessDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text("THÔNG BÁO", style: TextStyle(color: Colors.red)),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('OK', style: TextStyle(fontSize: 18)),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UserPage()));
          },
        ),
      ],
    ),
  );
}

Future<bool?> showSuccessDialogOrder(BuildContext context, String msg) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Center(
        child: Text(
          msg,
          style: TextStyle(color: Colors.green, fontSize: 18),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 100,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Quay Về Trang Chủ',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text(
        'LỖI',
        style: TextStyle(color: Colors.red),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('OK', style: TextStyle(fontSize: 18)),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}
