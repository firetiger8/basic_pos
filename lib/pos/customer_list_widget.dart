import 'package:flutter/material.dart';

class CustomerListScreen extends StatelessWidget {
  CustomerListScreen({Key? key}) : super(key: key) {}
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    var sHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
          height: sHeight * 0.8,
          width: sWidth * 0.7,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 2,
              blurRadius: 10,
              //offset: const Offset(0, 2), // changes position of shadow
            ),
          ], color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(32))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "CARI CUSTOMER",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 50, maxWidth: 300, minHeight: 30, maxHeight: 40),
                    child: Material(
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(fontSize: 12),
                        onChanged: null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            onPressed: () {
                              searchController.clear();
                            },
                            icon: const Icon(Icons.clear),
                            padding: EdgeInsets.zero,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              )),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              )),
                          labelText: 'Search Nama / No HP',
                        ),
                      ),
                    ),
                  ),
                  Material(
                      //borderRadius: BorderRadius.circular(32),
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(32))),
                            child: IconButton(
                                onPressed: null,
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ))),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 40,
                color: Colors.orange,
                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
                  Expanded(
                    child: Text(
                      "NO",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "NAME",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "PHONE NUMBER",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "POINT",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "TYPE",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "SELECTED",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}
