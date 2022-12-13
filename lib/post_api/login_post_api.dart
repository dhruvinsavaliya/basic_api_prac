import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPostApi extends StatefulWidget {
  const LoginPostApi({Key? key}) : super(key: key);

  @override
  State<LoginPostApi> createState() => _LoginPostApiState();
}

class _LoginPostApiState extends State<LoginPostApi> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 200),
                  TextFormField(
                    controller: userNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter username';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'username',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: passController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Password', prefixIcon: Icon(Icons.lock)),
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      if (formKey.currentState!.validate()) {
                        String msg = await isLogin(
                            username: userNameController.text,
                            password: passController.text);

                        if (msg == 'Successfully Login') {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                                SnackBar(
                                  content: Text(msg),
                                ),
                              )
                              .closed
                              .then(
                                (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Scaffold(
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                ),
                              );
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(msg),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
        isProgress == false
            ? const SizedBox()
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black26,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
      ],
    ));
  }

  Future<String> isLogin(
      {required String? username, required String? password}) async {
    setState(() {
      isProgress = true;
    });

    Map<String, dynamic> reqBody = {'username': username, 'password': password};

    http.Response response = await http.post(
        Uri.parse('http://tasks-demo.herokuapp.com/api/auth/signin'),
        body: reqBody);
    var result = jsonDecode(response.body);
    setState(() {
      isProgress = false;
    });
    if (response.statusCode == 200) {
      return 'Successfully Login';
    } else if (response.statusCode == 401) {
      return result['message'];
    } else {
      return result['message'];
    }
  }
}
