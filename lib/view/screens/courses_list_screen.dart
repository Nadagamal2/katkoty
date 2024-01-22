import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/packages/alarm/models/courses_categories.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_appBar.dart';
import 'package:katkoty/view/screens/course_details_screen.dart';

import '../../utils/strings.dart';
import '../El_Azqar/widget/custom_dialog.dart';

class CoursesList extends StatefulWidget {
  const CoursesList({super.key});

  @override
  State<CoursesList> createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  CoursesCategories? courseData;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getCourses();
  }

  getCourses() async {
    Response response = await Dio()
        .get("https://katkoty-app.com/admin/api/courses_categories.php");
    var data = jsonDecode(response.data);
    courseData = CoursesCategories.fromJson(data);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GetStorage box = GetStorage();

    final MyDialogController myDialogController = Get.put(MyDialogController());
    bool hasShownDialoge = box.read<bool>('hasShownDialogecourse') ?? false;
    if (!hasShownDialoge) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        myDialogController.showDefaultDialog(
            contant: const Text(
          improve,
          textAlign: TextAlign.center,
        ));
      });
      box.write('hasShownDialogecourse', true);
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'improve_yourself'.tr,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: courseData?.coursesCategories?.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CourseDetails(
                              categoryData:
                                  courseData!.coursesCategories![index])),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.27,
                        child: Column(children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                image: DecorationImage(
                                    image: NetworkImage(courseData
                                            ?.coursesCategories?[index].image ??
                                        ''),
                                    fit: BoxFit.cover)),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.18,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 220,
                                height: 49,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xfff6c116),
                                ),
                                child: Text(
                                  courseData?.coursesCategories?[index].title ??
                                      '--',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
