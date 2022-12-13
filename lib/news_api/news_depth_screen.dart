import 'package:api_prac/news_api/web_view_news_api.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

class NewDepthScreen extends StatefulWidget {
  const NewDepthScreen(
      {Key? key,
      required this.fullNews,
      required this.image,
      required this.title,
      required this.uploadTime,
      required this.publisherName,
      required this.extraUrl,
      required this.descriptionText})
      : super(key: key);
  final String? fullNews;
  final String? image;
  final String? title;
  final String? uploadTime;
  final String? publisherName;
  final String? extraUrl;
  final String? descriptionText;

  @override
  State<NewDepthScreen> createState() => _NewDepthScreenState();
}

class _NewDepthScreenState extends State<NewDepthScreen> {
  String? extraUrl;
  @override
  void initState() {
    extraUrl = widget.extraUrl;
    super.initState();
  }

  final String errorImage =
      'https://i.pinimg.com/564x/0f/37/10/0f37109d0cc005766e5f9e625467d884.jpg';

  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 60.w,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(bottom: 25.w),
                    child: Hero(
                      tag: widget.image == null ? errorImage : widget.image!,
                      child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.image == null
                              ? errorImage
                              : widget.image!)),
                    ),
                  ),
                  Row(
                    children: [
                      const BackButton(
                        color: Colors.white,
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert_outlined))
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40.w,
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      padding: EdgeInsets.only(top: 4.w, left: 3.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.black, width: 0.7.w)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title!,
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3.w,
                          ),
                          Text(
                            widget.publisherName!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 2.w),
                          Text(widget.uploadTime!,
                              style: const TextStyle(color: Colors.grey))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: SingleChildScrollView(
                  child: Text(
                    widget.fullNews!,
                    maxLines: isReadMore ? null : 3,
                    overflow: isReadMore
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                height: 2.w,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isReadMore = !isReadMore;
                  });
                },
                child: Text(isReadMore ? 'Read Less' : 'Read More'),
              ),
              SizedBox(
                height: 2.w,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WebViewNewsApi(url: widget.extraUrl),
                        ));
                  },
                  child: const Text('explore more')),
              ReadMoreText(
                widget.descriptionText!,
                trimCollapsedText: 'Read More',
                trimExpandedText: 'Read Less',
                trimLines: 2,
                trimMode: TrimMode.Line,
                lessStyle: const TextStyle(color: Colors.blue),
                moreStyle: const TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
