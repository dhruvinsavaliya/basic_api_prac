import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SharePlusText extends StatelessWidget {
  SharePlusText({Key? key}) : super(key: key);

  TextEditingController shareTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: shareTextController,
            decoration: const InputDecoration(labelText: 'Enter Name'),
          ),
          ElevatedButton(
              onPressed: () async {
                if (shareTextController.value.text.isNotEmpty) {
                  await Share.share(shareTextController.text);
                }
              },
              child: const Text('Share'))
        ],
      ),
    );
  }
}
