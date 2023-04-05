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
      Map result = await context.read<AuthManager>().login(
            _authData['username']!,
            _authData['password']!,
          );
      List ngay = result['ngay_sinh'].toString().split('-');
      User user = User(
        id: result['_id'],
        ho_ten: result['ho_ten'],
        cccd: result['cccd'],
        ngay_sinh: DateTime(
          int.parse(ngay[0]),
          int.parse(ngay[1]),
          int.parse(ngay[2]),
        ),
        gioi_tinh: result['gioi_tinh'],
        dia_chi: result['dia_chi'],
        so_dien_thoai: result['so_dien_thoai'],
        hinh_anh_tai_khoan: result['hinh_anh_tai_khoan'],
        tai_khoan: Account(
            cap_quyen: result['tai_khoan']['cap_quyen'],
            ten_dang_nhap: result['tai_khoan']['ten_dang_nhap'],
            mat_khau: result['tai_khoan']['mat_khau'],
            ngay_bat_dau_lam_viec: result['tai_khoan']
                ['ngay_bat_dau_lam_viec']),
      );
      context.read<UserManager>().setUser(user);
      if (result['message'] == null) {
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
                      Text('Login',
                          style: poppins.copyWith(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 30,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Please login to continue',
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
                                        labelText: 'Username',
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
                                        labelText: 'Password',
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
                                                .25,
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
                                                  'LOGIN ',
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
