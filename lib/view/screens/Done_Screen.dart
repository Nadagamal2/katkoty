
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:katkoty/main.dart';
 class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon( Icons.check,color: Colors.green,size: 50,),
          SizedBox(height: 20,),


          const Center(
              child: Text(
                'تم !',

                style: TextStyle(color:Colors.green, fontSize: 18),
              )),
          SizedBox(height: 20,),

          ElevatedButton(
              onPressed: () {
                Get.offAll(const HomePage());
              },
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.green),
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  textStyle:
                  MaterialStateProperty.all(TextStyle(fontSize: 15))),
              child: const Text( 'الذهاب الي الصفحة الرئيسية'))
        ],
      ),
    );
  }
}
