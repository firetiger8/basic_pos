// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final bool _secureText = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    var sHeight = MediaQuery.of(context).size.height;

    return Scaffold(key: _scaffoldKey, resizeToAvoidBottomInset: true, body: newMethod(sWidth, sHeight));
  }

  Center newMethod(double sWidth, double sHeight) {
    return Center(
      child: FittedBox(
        child: Container(
          width: sWidth * 0.4,
          height: sHeight * 0.6,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            boxShadow: [BoxShadow(blurRadius: 50, spreadRadius: 5, color: Colors.grey.shade300, offset: const Offset(0, 1))],
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Basic POS", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))],
                ),
              ),
              SizedBox(
                width: sWidth * 0.3,
                height: sHeight * 0.09,
                child: TextField(
                  controller: nameController,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700], letterSpacing: 1),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                    hintText: 'Email',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: sWidth * 0.3,
                  height: sHeight * 0.09,
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700], letterSpacing: 1),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.visibility_off,
                          size: 16,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: sWidth * 0.3,
                height: sHeight * 0.09,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
