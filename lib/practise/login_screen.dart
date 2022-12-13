// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Login Screen')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: userNameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '* required';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'UserName',
                    fillColor: Colors.grey.withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(200),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '* required';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'Email',
                    fillColor: Colors.grey.withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(200),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '* required';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'Password',
                    fillColor: Colors.grey.withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(200),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (formKey.currentState!.validate()) {
                      log('EMAIL=======>>${emailController.text}');
                      log('username=======>>${userNameController.text}');
                      log('password=======>>${passController.text}');

                      String msg = await isRegister(
                          email: emailController.text,
                          password: passController.text,
                          userName: userNameController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(msg),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('pls required filled'),
                        ),
                      );
                    }
                  },
                  child: const Text('SignUp'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> isRegister(
      {required String userName,
      required String email,
      required String password}) async {
    Map<String, dynamic> reqBody = {
      "username": userName,
      "email": email,
      "password": password
    };

    log('SIGNUP REQ BODY====>$reqBody');

    http.Response response = await http.post(
        Uri.parse('http://tasks-demo.herokuapp.com/api/auth/signup'),
        body: reqBody);

    log('SIGNUP RES ===========>>>${response.body}');

    var result = jsonDecode(response.body);

    return result['message'];
  }
}
