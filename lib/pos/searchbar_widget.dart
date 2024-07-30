import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchbarWidget extends StatefulWidget {
  SearchbarWidget({
    Key? key,
    required this.mode,
  }) : super(key: key);

  var mode = 1;

  @override
  State<SearchbarWidget> createState() => _SearchbarWidgetState();
}

class _SearchbarWidgetState extends State<SearchbarWidget> {
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  static final barcodeController = TextEditingController();
  static final prodNameController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  var enableSoftKeyboard = false;
  @override
  void dispose() {
    focusNode.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight * 0.99,
                    child: TextField(
                      controller: prodNameController,
                      style: const TextStyle(fontSize: 12),
                      keyboardType: enableSoftKeyboard ? TextInputType.text : TextInputType.none,
                      onTap: () {
                        prodNameController.clear();
                        barcodeController.clear();
                      },
                      onSubmitted: (value) {},
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        fillColor: Colors.grey[100],
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Cari Produk',
                        hintStyle: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight * 0.99,
                    child: RawKeyboardListener(
                      autofocus: true,
                      focusNode: focusNode,
                      onKey: (RawKeyEvent event) {
                        if (event is RawKeyDownEvent) {
                          FocusScope.of(context).requestFocus(focusNode2);
                          if (event.physicalKey == PhysicalKeyboardKey.enter) {
                            barcodeController.clear();
                          } else {
                            barcodeController.text += event.character!;
                          }
                        }
                      },
                      child: TextField(
                        controller: barcodeController,
                        keyboardType: enableSoftKeyboard ? TextInputType.text : TextInputType.none,
                        style: const TextStyle(fontSize: 12),
                        key: formKey,
                        autofocus: true,
                        focusNode: focusNode2,
                        onTap: () {
                          prodNameController.clear();
                          barcodeController.clear();
                        },
                        onSubmitted: (value) {},
                        onChanged: (text) {},
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          fillColor: Colors.grey[100],
                          filled: true,
                          prefixIcon: const Icon(Icons.search),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: 'Cari SKU',
                          hintStyle: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.99,
                    child: Center(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          enableSoftKeyboard = !enableSoftKeyboard;
                          if (!enableSoftKeyboard) {
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                            FocusScope.of(context).requestFocus(focusNode);
                          } else {
                            SystemChannels.textInput.invokeMethod('TextInput.show');
                          }
                        },
                        color: Colors.yellow,
                        icon: Icon(Icons.keyboard, color: Colors.grey[700], size: 30),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: constraints.maxHeight * 0.99,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.green),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)))),
                          onPressed: () {},
                          icon: const Icon(Icons.print, color: Colors.white),
                          label: const Text(
                            "PRINTER",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: constraints.maxHeight * 0.99,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)))),
                          onPressed: () {},
                          icon: const Icon(Icons.insert_chart, color: Colors.white),
                          label: const Text(
                            "REKAP KASIR",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
