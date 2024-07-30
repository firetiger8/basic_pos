import 'package:flutter/material.dart';

class ProductListWidget extends StatelessWidget {
  ProductListWidget({required this.mode});
  var mode = 1;
  var mH = 0.0; //maxHeight
  var mW = 0.0; //maxWidth
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      mH = constraints.maxHeight;
      mW = constraints.maxWidth;
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: mW * 0.19, mainAxisExtent: mH * 0.5, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemCount: 10,
          itemBuilder: (BuildContext ctx, index) {
            return ProductItemWidget(controller, index, mode);
          });
    });
  }
}

class ProductItemWidget extends StatelessWidget {
  ProductItemWidget(this.controller, this.index, this.mode);
  var controller;
  var index;
  var mode = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          decoration: BoxDecoration(
              color: controller.displayedProducts[index].status == "perfect" ? Colors.grey[200] : Colors.orange[100],
              // boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 1, spreadRadius: 0, offset: Offset(1, 3))],
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    //PRODUCT IMAGE
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    child: Material(
                      color: Colors.grey,
                      child: InkWell(
                        splashColor: Colors.blue, // Splash color
                        child: CachedNetworkImage(
                          imageUrl: "https://adminpanel.ringgo.co.id${controller.displayedProducts[index].prodImage}",
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          width: double.infinity,
                          height: constraints.maxHeight * 0.4,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  if (controller.displayedProducts[index].discountPusat > 0 || controller.displayedProducts[index].jumlahHargaGrosir > 0)
                    Positioned(
                      left: 5,
                      top: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.displayedProducts[index].discountPusat > 0)
                            Container(
                              padding: const EdgeInsets.all(2),
                              // height: 50,
                              decoration: BoxDecoration(
                                  color: controller.displayedProducts[index].discountPusat > 30 ? Colors.red : Colors.yellow[700],
                                  borderRadius: const BorderRadius.all(Radius.circular(8))),
                              child: Row(
                                children: [
                                  Text(
                                    "${controller.displayedProducts[index].discountPusat}%",
                                    style: const TextStyle(fontSize: 8, color: Colors.white),
                                  ),
                                  const SizedBox(width: 5),
                                  const ClipOval(
                                    child: Image(
                                        image: AssetImage('assets/icons/circle-discount.jpg'),
                                        width: 10,
                                        //height: sHeight * 0.07,
                                        fit: BoxFit.fill),
                                  )
                                ],
                              ),
                            ),
                          const SizedBox(height: 2),
                          if (controller.displayedProducts[index].jumlahHargaGrosir > 0)
                            Container(
                              padding: const EdgeInsets.all(2),
                              // height: 50,
                              decoration: const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))),
                              child: Row(
                                children: const [
                                  Text(
                                    "GROSIR",
                                    style: TextStyle(fontSize: 8, color: Colors.white),
                                  ),
                                  SizedBox(width: 5),
                                  ClipOval(
                                    child: Image(
                                        image: AssetImage('assets/icons/circle-grosir.jpg'),
                                        width: 10,
                                        //height: sHeight * 0.07,
                                        fit: BoxFit.fill),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (controller.displayedProducts[index].status == "imperfect")
                    Positioned(
                      left: 5,
                      top: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            // height: 50,
                            decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(8))),
                            child: Row(
                              children: const [
                                Text(
                                  "IMPERFECT",
                                  style: TextStyle(fontSize: 8, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  Positioned.fill(
                      child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.lightGreenAccent.withAlpha(100),
                          onTap: () {
                            // if (controller.displayedProducts[index].jumlahHargaGrosir > 0) {
                            Get.dialog(AlertDialog(
                              contentPadding: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                              title: Text(
                                  controller.displayedProducts[index].status == "perfect"
                                      ? 'Daftar Harga ${controller.displayedProducts[index].name}'
                                      : 'Daftar Harga ${controller.displayedProducts[index].name} - Imperfect',
                                  style: const TextStyle(fontSize: 14)),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...getHargaBarang(),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Close"),
                                  onPressed: () => Get.back(),
                                ),
                              ],
                            ));
                            // }
                          },
                        )),
                  )),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    //SHOW PRODUCT NAME
                    height: constraints.maxHeight * 0.25,
                    //margin: EdgeInsets.only(top: 5),
                    // color: Colors.yellow,
                    child: Center(
                      child: Text(
                        "${controller.displayedProducts[index].id} / ${controller.displayedProducts[index].name}",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const DottedLine(
                    dashColor: Colors.grey,
                    dashLength: 5,
                    dashGapLength: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (controller.displayedProducts[index].bisaDitimbang == 0) ...[
                    Container(
                      //SHOW PRODUCT PRICE
                      height: constraints.maxHeight * 0.3,
                      padding: const EdgeInsets.only(left: 3),
                      // color: Colors.pink,
                      child:
                          addPriceAndButton(product: controller.displayedProducts[index], height: constraints.maxHeight, width: constraints.maxWidth),
                    ),
                  ] else if (controller.displayedProducts[index].bisaDitimbang == 1 && AppConstant.bisaDitimbang) ...[
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (PrinterController.to.selectedPrinterType.value != "" || !AppConstant.harusAdaPrinter) {
                            // String key = controller.displayedProducts[index].id.toString();
                            // key += "/${controller.displayedProducts[index].pmiUnits[0]}";
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ChangeCartQtyScreen(controller, "", controller.displayedProducts[index].id,
                                      controller.displayedProducts[index].pmiUnits[0], mode, true, 'product-item');
                                  //return Text("abc");
                                });

                            // CartController.to.addToCart(key, false, 1.00, mode);
                          } else {
                            Get.dialog(AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              title: const Text(
                                'Info',
                                style: TextStyle(fontSize: 14),
                              ),
                              content: const Text(
                                'Belum ada Printer yang dipilih.\nHarap memilih printer terlebih dahulu',
                                style: TextStyle(fontSize: 12),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Close"),
                                  onPressed: () => Get.back(),
                                ),
                              ],
                            ));
                          }
                        },
                        child: const Text(
                          "Tambah",
                          style: TextStyle(color: Colors.white),
                        ))
                  ] else if (controller.displayedProducts[index].bisaDitimbang == 1 && !AppConstant.bisaDitimbang) ...[
                    Container(
                      //SHOW PRODUCT PRICE
                      height: constraints.maxHeight * 0.3,
                      padding: const EdgeInsets.only(left: 3),
                      // color: Colors.pink,
                      child:
                          addPriceAndButton(product: controller.displayedProducts[index], height: constraints.maxHeight, width: constraints.maxWidth),
                    ),
                  ]

                  // Container(
                  //   //SHOW PRODUCT PRICE
                  //   height: 50,
                  //   //color: Colors.yellow,
                  //   child: addPriceAndButton(product: controller.displayedProducts[index]),
                  // ),
                  // if (controller.displayedProducts[index].totalUnit == 2) ...[
                  //   Container(
                  //     //SHOW PRODUCT PRICE SUB CATEGORY (BIG UNIT)
                  //     height: 50,
                  //     // color: Colors.yellow,
                  //     child: addPriceAndButton(product: controller.displayedProducts[index], unit: 2),
                  //   ),
                  // ]
                ],
              ),
            ],
          ));
    });
  }

  List<Widget> getHargaBarang() {
    List<Widget> result = [];
    var qty = 0;
    var price = 0;
    List<int> qtyGrosir = [
      controller.displayedProducts[index].grosirQty1,
      controller.displayedProducts[index].grosirQty2,
      controller.displayedProducts[index].grosirQty3,
      controller.displayedProducts[index].grosirQty4,
      controller.displayedProducts[index].grosirQty5,
    ];
    List<int> priceGrosir = [
      controller.displayedProducts[index].grosirPrice1,
      controller.displayedProducts[index].grosirPrice2,
      controller.displayedProducts[index].grosirPrice3,
      controller.displayedProducts[index].grosirPrice4,
      controller.displayedProducts[index].grosirPrice5,
    ];
    result.add(const ListTile(
      visualDensity: VisualDensity(vertical: -4),
      dense: true,
      leading: Text(
        "Harga Normal :",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
    var adaDiscImperfectSmall = false;
    var adaDiscImperfectBig = false;
    var discImperfectSmall = 0;
    var discImperfectBig = 0;

    if (controller.displayedProducts[index].status == "imperfect") {
      if (controller.displayedProducts[index].pmiUnits.length == 1) {
        adaDiscImperfectSmall = true;
        discImperfectSmall = controller.displayedProducts[index].pmiDiscountImperfect[0];
      } else if (controller.displayedProducts[index].pmiUnits.length == 2) {
        adaDiscImperfectSmall = true;
        adaDiscImperfectBig = true;
        discImperfectSmall = controller.displayedProducts[index].pmiDiscountImperfect[0];
        discImperfectBig = controller.displayedProducts[index].pmiDiscountImperfect[1];
      }
    }
    result.add(ListTile(
      visualDensity: const VisualDensity(vertical: -4),
      dense: true,
      leading: Text(
        "Small Unit (${controller.displayedProducts[index].smallUnit})",
        style: const TextStyle(fontSize: 10),
      ),
      trailing: Text(
        "Harga ${CurrencyFormat.convertToIdr(controller.displayedProducts[index].price, 0)}",
        style: controller.displayedProducts[index].discountPusat > 0 ||
                (controller.displayedProducts[index].status == "imperfect" && adaDiscImperfectSmall)
            ? const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 10)
            : const TextStyle(fontSize: 10),
      ),
    ));
    if (controller.displayedProducts[index].discountPusat > 0) {
      result.add(ListTile(
        visualDensity: const VisualDensity(vertical: -4),
        dense: true,
        leading: Text(
          "Discount ${controller.displayedProducts[index].discountPusat}%",
          style: const TextStyle(fontSize: 10),
        ),
        trailing:
            Text("Harga ${CurrencyFormat.convertToIdr(controller.displayedProducts[index].discountPrice, 0)}", style: const TextStyle(fontSize: 10)),
      ));
    }

    if ((controller.displayedProducts[index].status == "imperfect" && adaDiscImperfectSmall)) {
      result.add(ListTile(
        visualDensity: const VisualDensity(vertical: -4),
        dense: true,
        leading: Text(
          "Discount Imperfect $discImperfectSmall%",
          style: const TextStyle(fontSize: 10),
        ),
        trailing:
            Text("Harga ${CurrencyFormat.convertToIdr(controller.displayedProducts[index].imperfectPrice, 0)}", style: const TextStyle(fontSize: 10)),
      ));
    }
    result.add(const SizedBox(height: 15));
    result.add(ListTile(
      visualDensity: const VisualDensity(vertical: -4),
      dense: true,
      leading: Text(
        "Big Unit (${controller.displayedProducts[index].bigUnit})",
        style: const TextStyle(fontSize: 10),
      ),
      trailing: Text(
        "Harga ${CurrencyFormat.convertToIdr(controller.displayedProducts[index].bigPrice, 0)}",
        style: (controller.displayedProducts[index].status == "imperfect" && adaDiscImperfectBig)
            ? const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 10)
            : const TextStyle(fontSize: 10),
      ),
    ));
    if ((controller.displayedProducts[index].status == "imperfect" && adaDiscImperfectBig)) {
      result.add(ListTile(
        visualDensity: const VisualDensity(vertical: -4),
        dense: true,
        leading: Text(
          "Discount Imperfect $discImperfectBig%",
          style: const TextStyle(fontSize: 10),
        ),
        trailing: Text("Harga ${CurrencyFormat.convertToIdr(controller.displayedProducts[index].imperfectBigPrice, 0)}",
            style: const TextStyle(fontSize: 10)),
      ));
    }
    if (controller.displayedProducts[index].jumlahHargaGrosir > 0) {
      result.add(const ListTile(
        visualDensity: VisualDensity(vertical: -4),
        dense: true,
        leading: Text(
          "Harga Grosir :",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
      for (var i = 0; i < controller.displayedProducts[index].jumlahHargaGrosir; i++) {
        qty = qtyGrosir[i];
        price = priceGrosir[i];
        result.add(ListTile(
          visualDensity: const VisualDensity(vertical: -4),
          dense: true,
          leading: Text(
            "Beli diatas $qty x ${controller.displayedProducts[index].bigUnit}",
            style: const TextStyle(fontSize: 10),
          ),
          trailing: Text("Harga ${CurrencyFormat.convertToIdr(price, 0)}", style: const TextStyle(fontSize: 10)),
        ));
      }
    }
    return result;
  }

  Color getColor(unit) {
    switch (unit) {
      case 1:
        return Colors.green.shade900;

      case 2:
        return Colors.deepOrange;

      case 101:
        return Colors.green.shade900;

      default:
        return Colors.deepOrange;
    }
  }

  String getPrice(product, unit, withUnit) {
    switch (unit) {
      case 1:
        if (withUnit) {
          if (product.discountPusat > 0) {
            return "${CurrencyFormat.convertToIdr(product.discountPrice, 0)} / ${product.smallUnit}";
          } else {
            return "${CurrencyFormat.convertToIdr(product.price, 0)} / ${product.smallUnit}";
          }
        } else {
          return CurrencyFormat.convertToIdr(product.price, 0);
        }

      case 2:
        if (withUnit) {
          return "${CurrencyFormat.convertToIdr(product.bigPrice, 0)} / ${product.bigUnit}";
        } else {
          return CurrencyFormat.convertToIdr(product.bigPrice, 0);
        }

      case 101:
        if (withUnit) {
          return "${CurrencyFormat.convertToIdr(product.imperfectPrice, 0)} / ${product.smallUnit} - IMP";
        } else {}
        return CurrencyFormat.convertToIdr(product.imperfectPrice, 0);

      default:
        if (withUnit) {
          return "${CurrencyFormat.convertToIdr(product.imperfectBigPrice, 0)} / ${product.bigUnit} - IMP";
        } else {
          return CurrencyFormat.convertToIdr(product.imperfectBigPrice, 0);
        }
    }
  }

  Widget addPriceAndButton({product, width, height}) {
    return Column(children: [
      for (var i = 0; i < product.totalUnit; i++)
        Row(
          children: [
            ClipRect(
              child: Material(
                color: product.pmiUnits[i] < 100 ? Colors.grey[200] : Colors.orange[100], // Button color
                child: InkWell(
                  splashColor: Colors.orange, // Splash color
                  onTap: () {
                    // String key = controller.displayedProducts[index].id.toString();
                    // key += "/${product.pmiUnits[i]}";
                    CartController.to.addToCart('prod-list', '', controller.displayedProducts[index].id, product.pmiUnits[i], false, 1.00, mode);
                  },
                  child: SizedBox(
                    //ADD TO CART (SMALL UNIT)
                    //PRICE (SMALL UNIT)
                    // color: i % 2 == 0 ? Colors.lightBlue : Colors.green,
                    width: width * 0.95,
                    height: height * 0.15,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.discountPusat > 0 && product.pmiUnits[i] == 1)
                          Text(
                            getPrice(product, product.pmiUnits[i], false),
                            //textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough, decorationThickness: 4,
                              //fontWeight: FontWeight.bold,
                              color: getColor(product.pmiUnits[i]),
                            ),
                          ),
                        Flexible(
                          child: Text(
                            getPrice(product, product.pmiUnits[i], true),
                            //textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 10,
                              overflow: TextOverflow.ellipsis,

                              //fontWeight: FontWeight.bold,
                              color: getColor(product.pmiUnits[i]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Container(
            //   //ADD TO CART BUTTON (SMALL UNIT)
            //   width: width * 0.2,
            //   height: height * 0.15,
            //   // color: i % 2 == 0 ? Colors.yellow : Colors.amber,
            //   child: IconButton(
            //       padding: EdgeInsets.zero,
            //       onPressed: () {
            //         String key = controller.displayedProducts[index].id.toString();
            //         key += "/${product.pmiUnits[i]}";
            //         CartController.to.addToCart(key, false, 1.00, mode);
            //       },
            //       icon: Icon(
            //         Icons.add_circle,
            //         color: getColor(product.pmiUnits[i]),
            //       )),
            // )
          ],
        )
    ]);
  }
}
