import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/view/treatment/widget/VideoScreenTemplate.dart';
import '../../utils/list.dart';
import '../El_Azqar/widget/custom_appBar.dart';

class TreatmentApathy extends StatelessWidget {
  const TreatmentApathy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'علاج الفتور',
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            treatment.length,
            (index) => GestureDetector(
              onTap: () {
                if (index < videoUrls.length) {
                  Get.to(() => VideoScreenTemplate(
                        videoUrl: videoUrls[index],
                        screenTitle: treatment[index],
                      ));
                }
              },
              child: Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
               //   color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                 border: Border.all(
      color: Colors.grey.withOpacity(0.3), 
      width: 1.0, 
    ),
                  
                ),
                child: Row(
                  children: [
                    const Icon(
                      color: Colors.green,
                      Icons.video_collection_outlined,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        child: Text(
                          treatment[index],
                          style:  TextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
