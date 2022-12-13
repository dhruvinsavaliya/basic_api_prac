import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detailed_page_2.dart';

class GetApi2nd extends StatelessWidget {
  const GetApi2nd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: (snapshot.data['data'] as List).length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailedPage2(
                              image: snapshot.data['data'][index]['avatar'],
                              name:
                                  "${snapshot.data['data'][index]['first_name']} ${snapshot.data['data'][index]['last_name']}",
                              emailId: snapshot.data['data'][index]['email'],
                            ),
                          ));
                    },
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data['data'][index]['avatar']),
                    ),
                    title: Text(
                        "${snapshot.data['data'][index]['first_name']} ${snapshot.data['data'][index]['last_name']}"),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future getData() async {
  http.Response response =
      await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
  Map<String, dynamic> fetchData = jsonDecode(response.body);
  return fetchData;
}
