import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:korea_food/invoice_history.dart';
import 'package:korea_food/models/managers/bill_manager.dart';
import 'package:korea_food/models/managers/discount_manager.dart';
import 'package:korea_food/models/managers/order_manager.dart';
import 'package:korea_food/models/managers/product_manager.dart';
import 'package:korea_food/models/managers/table_manager.dart';
import 'package:korea_food/models/managers/user_manager.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'models/managers/auth_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) {
            return AuthManager();
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) {
            return TablesManager();
          },
        ),
        ChangeNotifierProvider<UserManager>(
          create: (ctx) {
            return UserManager();
          },
        ),
        ChangeNotifierProvider<ProductManager>(
          create: (ctx) {
            return ProductManager();
          },
        ),
        ChangeNotifierProvider<OrderManager>(
          create: (ctx) {
            return OrderManager();
          },
        ),
        ChangeNotifierProvider<DiscountManager>(
          create: (ctx) {
            return DiscountManager();
          },
        ),
        ChangeNotifierProvider<BillsManager>(
          create: (ctx) {
            return BillsManager();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KoreaFood',
        home: AnimatedSplashScreen(
          duration: 2000,
          splashIconSize: 200,
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'KoreaFood',
                style: TextStyle(
                    fontFamily: 'Dancing Script',
                    color: Colors.white,
                    fontSize: 40),
              ),
              Icon(
                Icons.food_bank_outlined,
                color: Colors.white,
                size: 100,
              )
            ],
          ),
          nextScreen: const LoginPage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Color.fromARGB(255, 225, 207, 41),
        ),
      ),
    );
  }
}
