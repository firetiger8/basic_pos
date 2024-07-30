// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login/login_page.dart';

void main() {
  runApp(const BasicPOS());
}

class BasicPOS extends StatelessWidget {
  const BasicPOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic POS System',
      theme: ThemeData(
          // Define the default brightness and colors.
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
          fontFamily: 'Poppins'),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Basic POS"),
        ),
        body: LoginPage(),
      ),
    );
  }
}
