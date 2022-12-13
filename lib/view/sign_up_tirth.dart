// ignore_for_file: use_build_context_synchronously, unused_catch_clause

import 'dart:convert';
import 'dart:developer';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final form = GlobalKey<FormState>();
  bool isProgress = false;
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple)),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    try {
                      setState(() {
                        isProgress = true;
                      });
                      if (form.currentState!.validate()) {
                        log('EMAIL=======>>${emailController.text}');
                        log('username=======>>${userNameController.text}');
                        log('password=======>>${passController.text}');

                        String msg = await isRegisters(
                            userName: userNameController.text,
                            email: emailController.text,
                            password: passController.text);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(msg.toString())));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('pls required filled'),
                          ),
                        );
                      }
                      setState(() {
                        isProgress = false;
                      });
                    } on Exception catch (z) {
                      setState(() {
                        isProgress = false;
                      });
                    }
                  },
                  child: const Text('Register'),
                ),
              )
            ],
          ),
          isProgress
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

Future<String> isRegisters(
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
