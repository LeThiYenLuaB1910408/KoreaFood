import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:korea_food/change_password.dart';
import 'package:korea_food/const.dart';
import 'package:korea_food/homepage.dart';
import 'package:provider/provider.dart';
import 'package:korea_food/invoice_history.dart';
import 'package:korea_food/models/managers/user_manager.dart';
import 'package:korea_food/models/user_model.dart';

import 'edit_user.dart';
import 'login.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // Future<void> _refreshUser(BuildContext context) async {
  //   await context.read<UserManager>().fetchUser();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _refreshUser(context);
  // }

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserManager>().user;
    return SafeArea(child: Scaffold(
      body: FutureBuilder(builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(225, 207, 41, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 9,
                      spreadRadius: -4,
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      icon: Icon(Icons.home, color: Colors.white, size: 28)),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height * .88,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Center(
                          child: Container(
                        height: 120,
                        width: 120,
                        margin: EdgeInsets.only(right: 10, bottom: 10),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 5,
                              spreadRadius: -3),
                        ], borderRadius: BorderRadius.circular(60)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserPage()));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset(
                              'assets/images/${user.hinh_anh_tai_khoan}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
                      Text(
                        user.ho_ten,
                        style: poppins.copyWith(
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Text('Thông tin',
                              style: poppins.copyWith(
                                color: Colors.grey,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(
                                0.0,
                                0.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: -5.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: Color.fromARGB(255, 225, 207, 41),
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Sđt: ',
                                  style: poppins.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      user.so_dien_thoai,
                                      style: poppins.copyWith(
                                        color: Color.fromARGB(255, 0, 0, 0)
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.mail,
                                  color: Color.fromARGB(255, 225, 207, 41),
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Email: ',
                                  style: poppins.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      user.email,
                                      style: poppins.copyWith(
                                        color: Color.fromARGB(255, 0, 0, 0)
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Color.fromARGB(255, 225, 207, 41),
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Địa chỉ: ',
                                  style: poppins.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      user.dia_chi,
                                      style: poppins.copyWith(
                                        color: Color.fromARGB(255, 0, 0, 0)
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  color: Color.fromARGB(255, 225, 207, 41),
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Ngày sinh: ',
                                  style: poppins.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      DateFormat.yMMMd()
                                          .format(user.ngay_sinh)
                                          .toString(),
                                      style: poppins.copyWith(
                                        color: Color.fromARGB(255, 0, 0, 0)
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Text('Lựa chọn khác',
                              style: poppins.copyWith(
                                color: Colors.grey,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(
                                0.0,
                                0.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: -5.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => UserEditProfile(
                                      user: user,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: Color.fromARGB(255, 225, 207, 41),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          'Chỉnh sửa thông tin',
                                          style: poppins.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(3),
                                        child: const Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          size: 14,
                                          color:
                                              Color.fromARGB(255, 225, 207, 41),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => InvoiceHistoryPage(),
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.assignment,
                                      size: 16,
                                      color: Color.fromARGB(255, 225, 207, 41),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          'Lịch sử hóa đơn',
                                          style: poppins.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(3),
                                        child: const Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          size: 14,
                                          color:
                                              Color.fromARGB(255, 225, 207, 41),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => ChangePassword(),
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.change_circle,
                                      size: 16,
                                      color: Color.fromARGB(255, 225, 207, 41),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Text(
                                          'Đổi mật khẩu',
                                          style: poppins.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(3),
                                        child: const Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          size: 14,
                                          color:
                                              Color.fromARGB(255, 225, 207, 41),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(
                                0.0,
                                0.0,
                              ),
                              blurRadius: 1.0,
                              spreadRadius: -1.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Container(
                            color: Colors.grey.shade300,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                // context.read<AuthManager>().logout();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                    (route) => false);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.arrowRightFromBracket,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Đăng Xuất',
                                    style: poppins.copyWith(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        );
      }),
    ));
  }
}
