import 'package:basic_pos/pos/cart_header_widget.dart';
import 'package:basic_pos/pos/category_widget.dart';
import 'package:basic_pos/pos/searchbar_widget.dart';
import 'package:flutter/material.dart';

import 'cart_total_widget.dart';
import 'cart_widget.dart';
import 'product_list_widget.dart';

class PosPage extends StatelessWidget {
  PosPage({super.key});
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  /*
   * CASHIER SCREEN   
   */

  //lebar layout center menu
  static const double CENTER_LS_W = 0.75;
  //untuk tinggi header bar search landscape
  static const double CENTER_HEADERBAR_LS_H = 0.1;
  //untuk tinggi produk kategori dan sub kategori
  static const double CENTER_CATEGORYPRODUCT_LS_H = 0.08;
  //untuk tinggi produk list
  static const double CENTER_PRODUCTLIST_LS_H = 0.79;
  //untuk bagian list produk yang dibelanjakan

  //lebar layout bagian right menu list belanja
  static const double RIGHT_LS_W = 0.25;
  //tinggi header transaksi
  static const double RIGHT_HEADER_LS_H = 0.1;
  //tinggi list belanja
  static const double RIGHT_CARTLIST_LS_H = 0.7;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height; //552.8638200609188
    screenWidth = MediaQuery.of(context).size.width; //961.5022957581195
    Future<bool?> _showBackDialog() {
      return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'Are you sure you want to leave this page?',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = await _showBackDialog() ?? false;
          if (context.mounted && shouldPop) {
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 40,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SizedBox(width: 10), Text("Basic POS ", style: TextStyle(color: Colors.black, fontSize: 14))],
                ),
              ),
              body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  //** CENTER MENU */
                  height: screenHeight - 50,
                  width: screenWidth * CENTER_LS_W,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * CENTER_LS_W,
                        height: (screenHeight) * CENTER_HEADERBAR_LS_H,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: SearchbarWidget(mode: 1),
                      ),
                      Container(
                        //** CATEGORY AND SUBCATEGORY WIDGETS */
                        width: screenWidth * CENTER_LS_W,
                        height: (screenHeight) * CENTER_CATEGORYPRODUCT_LS_H,
                        color: Colors.white,
                        child: CategoryWidget(mode: 1),
                      ),
                      Expanded(
                        //** PRODUCT DISPLAY WIDGETS */
                        child: Container(padding: const EdgeInsets.all(4), color: Colors.white, child: ProductListWidget(mode: 1)),
                      ),
                    ],
                  ),
                ),
                Container(
                  //** RIGHT MENU */
                  height: screenHeight,
                  width: screenWidth * RIGHT_LS_W,
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      SizedBox(
                        height: (screenHeight) * RIGHT_HEADER_LS_H,
                        child: const CartHeaderWidget(),
                      ),
                      SizedBox(
                        width: screenWidth * RIGHT_LS_W,
                        height: (screenHeight) * RIGHT_CARTLIST_LS_H,
                        child: CartWidget(),
                      ),
                      Expanded(
                        child: CartTotalWidget(mode: 1),
                      ),
                    ],
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
