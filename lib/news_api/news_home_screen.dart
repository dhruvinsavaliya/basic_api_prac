import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import 'news_api_get_res_model.dart';
import 'news_depth_screen.dart';

class NewsHomeScreen extends StatelessWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  final String errorImage =
      'https://i.pinimg.com/564x/0f/37/10/0f37109d0cc005766e5f9e625467d884.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Articles"),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<NewsApiGetResModel>(
        future: getNewsData(),
        builder: (context, AsyncSnapshot<NewsApiGetResModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              itemCount: snapshot.data!.articles!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.articles![index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewDepthScreen(
                              image: data.urlToImage,
                              title: data.title,
                              publisherName: data.source!.name,
                              uploadTime: data.publishedAt,
                              fullNews: data.content,
                              extraUrl: data.url,
                              descriptionText: data.description,
                            ),
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Hero(
                          tag:
                              '${data.urlToImage == null ? errorImage : data.urlToImage}',
                          child: Container(
                            height: 50.w,
                            width: double.maxFinite,
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${data.urlToImage == null ? errorImage : data.urlToImage}')),
                          ),
                        ),
                        SizedBox(
                          height: 1.w,
                        ),
                        Text(
                          "${data.title}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 0.5.w,
                        ),
                        Text(
                          '${data.publishedAt}',
                          maxLines: 1,
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(thickness: 2),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<NewsApiGetResModel> getNewsData() async {
  http.Response response = await http.get(Uri.parse(
      'https://newsapi.org/v2/everything?q=tesla&from=2022-10-11&sortBy=publishedAt&apiKey=6c5a2cd029a44eb186c8640325bd2901'));

  var result = jsonDecode(response.body);

  NewsApiGetResModel newsApiGetResModel = NewsApiGetResModel.fromJson(result);
  log('${newsApiGetResModel.status}');

  return newsApiGetResModel;
}
