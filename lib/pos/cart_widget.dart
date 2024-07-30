import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import 'cart_item_widget.dart';

class CartWidget extends StatelessWidget {
  CartWidget({Key? key, mode}) : super(key: key);
  var mode = 1;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        id: "cartList",
        builder: (controller) {
          if (controller.isCartEmpty.value) {
            return const Center(child: Text("Cart Empty"));
          } else {
            return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              return ListView.builder(
                  itemCount: controller.cartItems.length,
                  controller: controller.myScrollController,
                  itemBuilder: (BuildContext ctx, index) {
                    // debugPrint(controller.cartItems.length.toString());
                    if (controller.isCartEmpty.value) {
                      return const Center(child: Text("Cart Empty"));
                    } else {
                      return CartItemWidget(controller, index, mode, constraints);
                    }
                  });
            });
          }
        });
  }
}

class CartItemWidget extends StatelessWidget {
  CartItemWidget(this.controller, this.index, this.mode, this.constraints);
  var controller;
  var index;
  var mode;
  var constraints;

  String getPrice(product, unit, withUnit) {
    switch (unit) {
      case 1:
        if (withUnit) {
          if (product['pDiscountPusat'] > 0) {
            return "${CurrencyFormat.convertToIdr(product['pDiscountPrice'], 0)} / ${product['pSmallUnit']}";
          } else {
            return "${CurrencyFormat.convertToIdr(product['pSmallPrice'], 0)} / ${product['pSmallUnit']}";
          }
        } else {
          return CurrencyFormat.convertToIdr(product['pSmallPrice'], 0);
        }
      case 2:
        if (product['pJumlahHargaGrosir'] > 0 && product['pQtyInUnit'] >= product['pGrosirQty1']) {
          var qtyGrosir = [
            product['pGrosirQty1'],
            product['pGrosirQty2'],
            product['pGrosirQty3'],
            product['pGrosirQty4'],
            product['pGrosirQty5'],
          ];
          var priceGrosir = [
            product['pGrosirPrice1'],
            product['pGrosirPrice2'],
            product['pGrosirPrice3'],
            product['pGrosirPrice4'],
            product['pGrosirPrice5'],
          ];
          var idx = 0;

          for (var i = 0; i < product['pJumlahHargaGrosir']; i++) {
            if (product['pQtyInUnit'] >= qtyGrosir[i]) {
              idx = i;
            }
          }

          if (withUnit) {
            return "${CurrencyFormat.convertToIdr(priceGrosir[idx], 0)} / ${product['pBigUnit']}";
          } else {
            return CurrencyFormat.convertToIdr(product['pBigPrice'], 0);
          }
        } else {
          return "${CurrencyFormat.convertToIdr(product['pBigPrice'], 0)} / ${product['pBigUnit']}";
        }

      case 101:
        return "${CurrencyFormat.convertToIdr(product['pImperfectPrice'], 0)} / ${product['pSmallUnit']} - IMP";

      default:
        return "${CurrencyFormat.convertToIdr(product['pImperfectBigPrice'], 0)} / ${product['pBigUnit']} - IMP";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      width: constraints.maxWidth * 0.9,
      height: constraints.maxHeight * 0.24,
      // decoration: BoxDecoration(
      //   // color: Colors.yellow,

      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.4),
      //       spreadRadius: 1,
      //       blurRadius: 5,
      //       offset: const Offset(3, 5), // changes position of shadow
      //     ),
      //   ],
      // ),
      child: Row(
        children: [
          Container(
            //CART MAIN ITEM
            width: constraints.maxWidth * 0.85,
            decoration: const BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          //PRODUCT IMAGE
                          width: constraints.maxWidth * 0.2,
                          //color: Colors.green,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                            child: CachedNetworkImage(
                              imageUrl: "https://adminpanel.ringgo.co.id${controller.cartItems.values.elementAt(index)['pImage']}",
                              //"https://adminpanel.ringgo.co.id${controller.cartItems.getentries.elementAt(index).key}",
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              height: constraints.maxHeight * 0.24,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (controller.cartItems.values.elementAt(index)['pUnitType'] > 100)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(color: Colors.red),
                              child: const Text(
                                "IMP",
                                style: TextStyle(color: Colors.white, fontSize: 8),
                              ),
                            ),
                          ),
                        if (controller.cartItems.values.elementAt(index)['pDiscountPusat'] > 0)
                          Positioned(
                            top: 5,
                            left: 5,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              // height: 50,
                              decoration: BoxDecoration(
                                  color: controller.cartItems.values.elementAt(index)['pDiscountPusat'] > 30 ? Colors.red : Colors.yellow[700],
                                  borderRadius: const BorderRadius.all(Radius.circular(8))),
                              child: Row(
                                children: [
                                  Text(
                                    "${controller.cartItems.values.elementAt(index)['pDiscountPusat']}%",
                                    style: const TextStyle(fontSize: 6, color: Colors.white),
                                  ),
                                  const SizedBox(width: 2),
                                  const ClipOval(
                                    child: Image(
                                        image: AssetImage('assets/icons/circle-discount.jpg'),
                                        width: 8,
                                        //height: sHeight * 0.07,
                                        fit: BoxFit.fill),
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (controller.cartItems.values.elementAt(index)['pJumlahHargaGrosir'] > 0)
                          Positioned(
                            top: controller.cartItems.values.elementAt(index)['pDiscountPusat'] > 0 ? 20 : 5,
                            left: 5,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              // height: 50,
                              decoration: const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))),
                              child: Row(
                                children: const [
                                  Text(
                                    "GROSIR",
                                    style: TextStyle(fontSize: 6, color: Colors.white),
                                  ),
                                  SizedBox(width: 2),
                                  ClipOval(
                                    child: Image(
                                        image: AssetImage('assets/icons/circle-grosir.jpg'),
                                        width: 8,
                                        //height: sHeight * 0.07,
                                        fit: BoxFit.fill),
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    Container(
                        //PRODUCT MAIN INFO
                        width: constraints.maxWidth * 0.65,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey.shade200,
                              width: 0.5,
                            ),
                          ),
                        ),
                        // color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              //PRODUT NAME
                              width: constraints.maxWidth * 0.65,
                              height: constraints.maxHeight * 0.08,
                              // color: Colors.purpleAccent,
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                controller.cartItems.values.elementAt(index)['pName'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                //PRODUCT PRICE
                                width: double.infinity,
                                height: constraints.maxHeight * 0.08,
                                // color: Colors.pink,
                                padding: const EdgeInsets.only(left: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (controller.cartItems.values.elementAt(index)['pDiscountPusat'] > 0 &&
                                        controller.cartItems.values.elementAt(index)['pUnitType'] == 1)
                                      Text(
                                        getPrice(controller.cartItems.values.elementAt(index),
                                            controller.cartItems.values.elementAt(index)['pUnitType'], false),
                                        maxLines: 2,

                                        // controller.cartItems.values.elementAt(index)['pUnitType'] == 1
                                        //     ? "${CurrencyFormat.convertToIdr(controller.cartItems.values.elementAt(index)['pSmallPrice'], 0)} / ${controller.cartItems.values.elementAt(index)['pSmallUnit']}"
                                        //     : "${CurrencyFormat.convertToIdr(controller.cartItems.values.elementAt(index)['pBigPrice'], 0)} / ${controller.cartItems.values.elementAt(index)['pBigUnit']}",
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.grey[700],
                                          decoration: TextDecoration.lineThrough,
                                          decorationThickness: 4,
                                        ),
                                      ),
                                    if (controller.cartItems.values.elementAt(index)['pJumlahHargaGrosir'] > 0 &&
                                        controller.cartItems.values.elementAt(index)['pQtyInUnit'] >=
                                            controller.cartItems.values.elementAt(index)['pGrosirQty1'] &&
                                        controller.cartItems.values.elementAt(index)['pUnitType'] == 2)
                                      Text(
                                        getPrice(controller.cartItems.values.elementAt(index),
                                            controller.cartItems.values.elementAt(index)['pUnitType'], false),
                                        maxLines: 2,

                                        // controller.cartItems.values.elementAt(index)['pUnitType'] == 1
                                        //     ? "${CurrencyFormat.convertToIdr(controller.cartItems.values.elementAt(index)['pSmallPrice'], 0)} / ${controller.cartItems.values.elementAt(index)['pSmallUnit']}"
                                        //     : "${CurrencyFormat.convertToIdr(controller.cartItems.values.elementAt(index)['pBigPrice'], 0)} / ${controller.cartItems.values.elementAt(index)['pBigUnit']}",
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.grey[700],
                                          decoration: TextDecoration.lineThrough,
                                          decorationThickness: 4,
                                        ),
                                      ),
                                    Flexible(
                                      child: Text(
                                        getPrice(controller.cartItems.values.elementAt(index),
                                            controller.cartItems.values.elementAt(index)['pUnitType'], true),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (!controller.cartItems.values.elementAt(index)['pGift'])
                                      SizedBox(
                                        width: constraints.maxWidth * 0.1,
                                        height: constraints.maxWidth * 0.1,
                                        // color: Colors.green,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            if (!controller.cartItems.values.elementAt(index)['pGift']) {
                                              String key = controller.cartItems.keys.elementAt(index);
                                              controller.decreaseQty(key);
                                            } else {
                                              Get.snackbar("Info", "Qty Gift tidak bisa diubah, hanya bisa dibatalkan",
                                                  icon: const Icon(Icons.warning),
                                                  snackPosition: SnackPosition.TOP,
                                                  duration: const Duration(seconds: 1),
                                                  barBlur: 5,
                                                  maxWidth: 400,
                                                  boxShadows: [const BoxShadow(blurRadius: 3, spreadRadius: 1)],
                                                  backgroundColor: Colors.yellowAccent);
                                              return;
                                            }
                                          },
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    //if (RegExp(r'^(\d* Gram)|(\d* Ikat)$')
                                    //HANYA YANG FORMATNYA XXX Gram yang bisa ditimbang
                                    if (controller.cartItems.values.elementAt(index)['pBisaDitimbang'] == 1 && AppConstant.bisaDitimbang) ...[
                                      GestureDetector(
                                          onTap: () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                String key = controller.cartItems.keys.elementAt(index);
                                                return ChangeCartQtyScreen(controller, key, 0, 0, mode, true, 'cart-item');
                                                //return Text("abc");
                                              }),
                                          child: Text(
                                            CurrencyFormat.thousandSeparator(controller.cartItems.values.elementAt(index)['pQty']),
                                            style: const TextStyle(fontSize: 12),
                                          ))
                                    ] else ...[
                                      Text(
                                        "${controller.cartItems.values.elementAt(index)['pQty']}",
                                        style: const TextStyle(color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                    if (!controller.cartItems.values.elementAt(index)['pGift'])
                                      SizedBox(
                                        // color: Colors.purple,
                                        width: constraints.maxWidth * 0.1,
                                        height: constraints.maxWidth * 0.1,
                                        child: IconButton(
                                          onPressed: () {
                                            if (!controller.cartItems.values.elementAt(index)['pGift']) {
                                              String key = controller.cartItems.keys.elementAt(index);
                                              controller.addToCart('cart', key, 0, 0, false, 1.00, mode);
                                            } else {
                                              Get.snackbar("Info", "Qty Gift tidak bisa diubah, hanya bisa dibatalkan",
                                                  icon: const Icon(Icons.warning),
                                                  snackPosition: SnackPosition.TOP,
                                                  duration: const Duration(seconds: 1),
                                                  barBlur: 5,
                                                  maxWidth: 400,
                                                  boxShadows: [const BoxShadow(blurRadius: 3, spreadRadius: 1)],
                                                  backgroundColor: Colors.yellowAccent);
                                              return;
                                            }
                                          },
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  //SHOW SUB TOTAL
                                  width: constraints.maxWidth * 0.3,
                                  child: Text(CurrencyFormat.convertToIdr(controller.cartItems.values.elementAt(index)['pSubTotal'], 0),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
                if (controller.cartItems.values.elementAt(index)['pGift'])
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.green,
                      child: const Text(
                        "GIFT",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            //DELETE BUTTON
            width: constraints.maxWidth * 0.1,
            height: constraints.maxHeight * 0.24,
            //padding: EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16))),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => controller.removeFromCart(controller.cartItems.entries.elementAt(index).key),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
