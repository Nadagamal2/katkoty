import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/models/ArticlesModelresponse.dart';
import 'package:katkoty/view/widgets/bnner_ad.dart';

import '../../controller/quotes_controller.dart';

class DrAhmedQuotes extends GetWidget<QuotesController> {
  const DrAhmedQuotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('اقتباسات'.tr),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.quotesMap.length,
                  itemBuilder: (BuildContext context, index) {
                    var sectionName =
                        (controller.quotesMap[index] as Article).title!;
                    return ExpansionTile(
                      title: Text(sectionName),
                      children: [
                        InkWell(
                          onTap: () {
                            controller.openQuotes(
                              context,
                              (controller.quotesMap[index] as Article).body!,
                            );
                          },
                          child: Card(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  sectionName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  height: 2,
                                  thickness: 2,
                                  indent: 100,
                                  endIndent: 100,
                                ),
                                Card(
                                    elevation: 5,
                                    margin: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.amber,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        (controller.quotesMap[index] as Article)
                                            .body!,
                                        maxLines: 10,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('قراءة المزيد ....'.tr),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                )),
          ),
        ],
      ),
      // drawer: Drawer(
      //   width: MediaQuery.of(context).size.width * 0.6,
      //   child: Column(
      //     children: [
      //       SafeArea(
      //         child: SizedBox(
      //           height: 150,
      //           child: Image.asset('assets/images/doctor_ahmed.png'),
      //         ),
      //       ),
      //       Expanded(
      //         child: Obx(() => ListView.builder(
      //           itemCount: controller.quotesMap.length,
      //           itemBuilder: (BuildContext context, index){
      //             var sectionName = controller.quotesMap.keys.toList()[index];
      //             return Card(
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(5)),
      //               child: ListTile(
      //                 title: Text('$sectionName'),
      //                 onTap: (){},
      //               ),
      //             );
      //           },
      //         )
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
