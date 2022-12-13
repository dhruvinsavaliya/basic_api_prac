import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details...'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getInfo(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: (snapshot.data['data'] as List).length,
              itemBuilder: (context, index) {
                final data = snapshot.data['data'][index];
                return ListTile(
                  title: Text('${data['first_name']} ${data['last_name']}'),
                  subtitle: Text('${data['email']}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('${data['avatar']}'),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future getInfo() async {
  http.Response response =
      await http.get(Uri.parse('https://reqres.in/api/users?page=2%27'));
  log('Response is ---> ${response.body}');
  Map<String, dynamic> result = jsonDecode(response.body);
  log('result ---> $result');
  return result;
}
