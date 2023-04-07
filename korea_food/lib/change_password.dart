import 'dart:io';

import 'package:flutter/material.dart';
import 'package:korea_food/dialog.dart';
import 'package:korea_food/models/managers/user_manager.dart';
import 'package:korea_food/models/user_account.dart';
import 'package:korea_food/models/user_model.dart';
import 'package:korea_food/user.dart';
import 'package:provider/provider.dart';
import 'package:korea_food/models/managers/auth_manager.dart';
import 'const.dart';
import 'homepage.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'oldPassword': '',
    'newPassword': '',
    'confirmPassword': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  bool hiddenPassword = true, errorLogin = false;

  // String username = '', password = '';
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;
    try {
      Map result = await context.read<UserManager>().changePassword(
            _authData['oldPassword']!,
            _authData['newPassword']!,
          );

      print(result);
      if (result['message'] == "Mật Khẩu Không Đúng!!!") {
        showMessageDialog(context, result['message']);
      } else {
        showSuccessDialog(
          context,
          result['message'],
        );
      }

      print(result);
    } catch (error) {
      showErrorDialog(
          context,
          (error is HttpException)
              ? error.toString()
              : 'Có lỗi trong quá trình đăng nhập!!');
    }

    _isSubmitting.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .965,
              child: Stack(children: [
                Positioned(
                  child: Image.asset(
                    'assets/images/banner.jpg',
                    width: 280,
                  ),
                  top: -7,
                  right: -120,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Change Password',
                          style: poppins.copyWith(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 30,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Please enter your password',
                          style: poppins.copyWith(
                              color: Color.fromARGB(255, 144, 142, 142),
                              decoration: TextDecoration.none,
                              fontSize: 16)),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                          key: _formKey,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    obscureText: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _authData['oldPassword'] = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock_open_outlined,
                                          color: Color.fromARGB(
                                              255, 105, 103, 103),
                                        ),
                                        labelStyle: poppins.copyWith(
                                            color: Color.fromARGB(
                                                255, 82, 81, 81)),
                                        labelText: 'Old Password',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    obscureText: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _authData['newPassword'] = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock_open_outlined,
                                          color: Color.fromARGB(
                                              255, 105, 103, 103),
                                        ),
                                        labelStyle: poppins.copyWith(
                                            color: Color.fromARGB(
                                                255, 82, 81, 81)),
                                        labelText: 'New Password',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    obscureText: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _authData['confirmPassword'] = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock_open_outlined,
                                          color: Color.fromARGB(
                                              255, 105, 103, 103),
                                        ),
                                        labelStyle: poppins.copyWith(
                                            color: Color.fromARGB(
                                                255, 82, 81, 81)),
                                        labelText: 'Confirm Password',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: _authData[
                                                            'confirmPassword'] ==
                                                        _authData['newPassword']
                                                    ? Colors.green
                                                    : Colors.red))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserPage()),
                                                (route) => false);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        decoration: BoxDecoration(
                                            color: Colors.red[900],
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        padding: EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'PREVIOUS',
                                              style: poppins.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ValueListenableBuilder<bool>(
                                      valueListenable: _isSubmitting,
                                      builder: (context, isSubmitting, child) {
                                        if (isSubmitting) {
                                          return const CircularProgressIndicator();
                                        }
                                        return TextButton(
                                          onPressed: _submit,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .3,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 225, 207, 41),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            padding: EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'CHANGE ',
                                                  style: poppins.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(
                                                  Icons.change_circle_outlined,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Positioned(
                  child: Image.asset(
                    'assets/images/banner.jpg',
                    width: 250,
                  ),
                  bottom: -8,
                  left: -140,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
