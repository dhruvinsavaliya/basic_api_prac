// ignore_for_file: unnecessary_brace_in_string_interps, dead_code, unused_local_variable, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   title: const Text('sign up POST API'),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Lottie.asset(height: 200, 'assets/lottie/login.json'),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent.shade100,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 25,
                            ),
                          ]),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'please enter username';
                              } else {
                                return null;
                              }
                              // else {
                              //   if (val.length < 5) {
                              //     return 'atleast 5 character name please';
                              //   } else {
                              //     return null;
                              //   }
                              // }
                            },
                            controller: userNameController,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: emailController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'please enter email';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            controller: passController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'please enter password';
                              } else {
                                return null;
                              }
                              // else {
                              //   if (val.length < 6) {
                              //     return 'atleast 6 character name please';
                              //   } else {
                              //     return null;
                              //   }
                              // }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                          const SizedBox(height: 50),
                          // ElevatedButton(
                          //     onPressed: () async {
                          //       FocusScope.of(context).unfocus();
                          //       if (formkey.currentState!.validate()) {
                          //         log('response of username ---> ${userNameController.text}');
                          //         log('response of email    ---> ${emailController.text}');
                          //         log('response of password ---> ${passController.text}');
                          //
                          //         String msg = await isLogin(
                          //             username: userNameController.text,
                          //             email: emailController.text,
                          //             password: passController.text);
                          //
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(
                          //             content: Text(msg),
                          //           ),
                          //         );
                          //       } else {
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           const SnackBar(
                          //             content: Text('invalid!'),
                          //           ),
                          //         );
                          //       }
                          //     },
                          //     child: const Text('Submit')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (formkey.currentState!.validate()) {
                      log('response of username ---> ${userNameController.text}');
                      log('response of email    ---> ${emailController.text}');
                      log('response of password ---> ${passController.text}');

                      String msg = await isLogin(
                          username: userNameController.text,
                          email: emailController.text,
                          password: passController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(msg.toString()),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('invalid!'),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit')),
            ),
          ],
        ),
      ),
    );
  }
}

Future isLogin(
    {required String? username,
    required String? email,
    required String? password}) async {
  Map<String, dynamic> reqBody = {
    'username': username,
    'email': email,
    'password': password
  };

  log('log of map<redbody> ---> $reqBody');

  http.Response response = await http.post(
      Uri.parse('http://tasks-demo.herokuapp.com/api/auth/signup'),
      body: reqBody);

  log('response of response ---> ${response.body}');

  var result = jsonDecode(response.body);

  log('response of result ---> $result');

  return result['message'];
}
