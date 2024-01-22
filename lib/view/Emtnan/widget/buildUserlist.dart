import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../service/shared_preference/user_preference.dart';
final userData2 = GetStorage();
Widget buildUserlist() => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              CircleAvatar(
              minRadius: 26,
              backgroundColor: Colors.transparent,
              backgroundImage: userData2.read('isLogged')==true? NetworkImage(
             '${userData2.read('photo')}'

              ): NetworkImage(
                  '${   UserPreferences.getUserpic()}'

              ),
            ),
            10.widthBox,
              Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text( userData2.read('isLogged')==true?"${userData2.read('Name')}":"${ UserPreferences.getUserName()}",
                    style: TextStyle(
                      color: Color(0xff606770),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )),
                Text("عدد النقاط = ",
                    style: TextStyle(
                      color: Color(0xffA3A3A3),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
          ],
        ),
      );

