// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPostApi extends StatefulWidget {
  const SignUpPostApi({Key? key}) : super(key: key);

  @override
  State<SignUpPostApi> createState() => _SignUpPostApiState();
}

class _SignUpPostApiState extends State<SignUpPostApi> {
  final formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();
  bool isProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: userNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter username';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(hintText: 'username'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter email';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(hintText: 'username'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter password';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(hintText: 'username'),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      try {
                        setState(() {
                          isProgress = true;
                        });
                        if (formKey.currentState!.validate()) {
                          String msg = await isSignUp(
                              userName: userNameController.text,
                              email: emailController.text,
                              password: passController.text);

                          if (msg == 'User was registered successfully!') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(msg)))
                                .closed
                                .then(
                                  (value) => Scaffold(
                                    appBar: AppBar(
                                      title: const Text('Login'),
                                    ),
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(msg)));
                          }
                          setState(() {
                            isProgress = false;
                          });
                        }
                      } on Exception catch (x) {
                        setState(() {
                          isProgress = false;
                        });
                        // TODO
                      }
                    },
                    child: const Text('SignUp'),
                  ),
                ],
              ),
            )),
        isProgress
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              )
            : const SizedBox()
      ],
    ));
  }

  /// method
  Future isSignUp(
      {required String? userName,
      required String? email,
      required String? password}) async {
    Map<String, dynamic> reqBody = {
      'username': userName,
      'email': email,
      'password': password
    };

    http.Response response = await http.post(
        Uri.parse('http://tasks-demo.herokuapp.com/api/auth/signup'),
        body: reqBody);

    var result = jsonDecode(response.body);
    return result['message'];
  }
}
