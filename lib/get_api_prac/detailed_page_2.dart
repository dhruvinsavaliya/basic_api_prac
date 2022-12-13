import 'package:flutter/material.dart';

class DetailedPage2 extends StatelessWidget {
  const DetailedPage2({Key? key, this.image, this.name, this.emailId})
      : super(key: key);

  final String? image;
  final String? name;
  final String? emailId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackButton(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                height: 400,
                width: double.maxFinite,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(1, -1),
                      blurRadius: 1),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-1, 1),
                      blurRadius: 1),
                ]),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Image(image: NetworkImage(image!)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(name!),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(emailId!)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
