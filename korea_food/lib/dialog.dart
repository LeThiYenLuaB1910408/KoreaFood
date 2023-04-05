import 'package:flutter/material.dart';
import 'package:korea_food/user.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Are you sure'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text('Yes'),
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
      title: Text("THÔNG BÁO"),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('okiii'),
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
      title: Text("THÔNG BÁO"),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('okiii'),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UserPage()));
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
        'LỖI!',
        style: TextStyle(color: Colors.red),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Oki'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}
