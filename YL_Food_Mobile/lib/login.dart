import 'dart:io';

import 'package:flutter/material.dart';
import 'package:korea_food/dialog.dart';
import 'package:korea_food/models/managers/user_manager.dart';
import 'package:korea_food/models/user_account.dart';
import 'package:korea_food/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:korea_food/models/managers/auth_manager.dart';
import 'const.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();
  bool hiddenPassword = true, errorLogin = false;

  // String username = '', password = '';
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;
    try {
      Map<String, dynamic> result = await context.read<AuthManager>().login(
            _authData['username']!,
            _authData['password']!,
          );
      if (result['message'] == null) {
        User user = User.fromJson(result);
        context.read<UserManager>().setUser(user);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false,
        );
      } else {
        showErrorDialog(context, 'Tên Đăng Nhập Hoặc Mật Khẩu Không Đúng');
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
                      Text('Đăng Nhập',
                          style: poppins.copyWith(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 30,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Vui lòng đang nhập để tiếp tục',
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
                                    onChanged: (value) {
                                      setState(() {
                                        _authData['username'] = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Color.fromARGB(
                                              255, 105, 103, 103),
                                        ),
                                        labelStyle: poppins.copyWith(
                                            color: Color.fromARGB(
                                                255, 82, 81, 81)),
                                        labelText: 'Tên đăng nhập',
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
                                        _authData['password'] = value;
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
                                        labelText: 'Mật khẩu',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
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
                                                .35,
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
                                                  'ĐĂNG NHẬP ',
                                                  style: poppins.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
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
