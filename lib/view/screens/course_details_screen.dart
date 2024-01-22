import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:katkoty/packages/alarm/models/course_details_model.dart';
import 'package:katkoty/packages/alarm/models/courses_categories.dart';
import 'package:katkoty/view/screens/youtube_video_screen.dart';

import '../El_Azqar/widget/custom_appBar.dart';

class CourseDetails extends StatefulWidget {
  final CoursesCategory categoryData;
  const CourseDetails({super.key, required this.categoryData});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  CoursesDetails? details;
  bool isLoading = true;
  getDetails() async {
    Response response = await Dio().get(
      'https://katkoty-app.com/admin/api/courses_content.php?categorie=${widget.categoryData.categorie}',
    );
    var data = response.data;
    details = CoursesDetails.fromJson(data);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.categoryData.title ?? '--',
        onPressed: () => Navigator.pop(context),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: details?.coursesContent?.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YoutubeVideoScreen(
                              content: details!.coursesContent![index]),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Color(0xffCDCDCD),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  /*  FittedBox(
                                    child: Text(
                                      widget.categoryData.title ?? '--',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppbarColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ), */
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(details
                                                    ?.coursesContent?[index]
                                                    .image ??
                                                ''),
                                            fit: BoxFit.cover)),
                                    //width: 145,
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: SizedBox(
                              //  width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      /*  width:
                                          MediaQuery.of(context).size.width * 0.43, */
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: Text(
                                        details?.coursesContent?[index].title ??
                                            '--',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      /*  width:
                                          MediaQuery.of(context).size.width * 0.5, */
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          details?.coursesContent?[index]
                                                  .description ??
                                              '--',
                                          style: const TextStyle(fontSize: 14),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
