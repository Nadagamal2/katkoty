import 'dart:convert';
import 'package:katkoty/view/Emtnan/widget/social_buttons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../controller/user_like_controller.dart';


import 'package:http/http.dart' as http;

import '../../../db/model/post_model.dart';
import '../../../models/get_user_post_model.dart';
import '../../../models/getlikes.dart';
import '../../../service/services/post_like.dart';
import '../../../service/shared_preference/user_preference.dart';
class ShareProfile extends StatefulWidget {
  const ShareProfile({super.key});

  @override
  State<ShareProfile> createState() => _ShareProfileState();
}

class _ShareProfileState extends State<ShareProfile> {
  final userData2 = GetStorage();
  Future<List<UserPost>?> getData2() async {
    final response = await http.get(Uri.parse(
        'https://katkoty-app.com/admin/api/community/get_user_posts.php?user_id=${userData2.read('id')}'));


    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      List jsonData = (data['user_posts']);
      return jsonData.map((Data) => UserPost.fromJson(Data)).toList();
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 400,
      child: FutureBuilder<List<UserPost>?>(
        future: getData2(),
        builder: (context,snapshot){
          print(snapshot.hasData);

          if(snapshot.hasData){
            List<UserPost>? item = snapshot.data;
            print(item!.length);
            return item!.length==0? Text('لا يوجد مشاركات',style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),): ListView.separated(
                itemBuilder: (context,index)=>Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        10.heightBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundImage:  userData2.read('isLogged')==true? NetworkImage(
                                  '${userData2.read('photo')}'

                              ): NetworkImage(
                                  '${   UserPreferences.getUserpic()}'

                              ),
                            ),
                            5.widthBox,
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          ' ${userData2.read('isLogged')==true?"${userData2.read('Name')}":"${ UserPreferences.getUserName()}"}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          item[index].createdAt.timeAgo(),
                                          style: const TextStyle(
                                            color: Color(0xffA3A3A3),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const Spacer(),
                                  // if (post.user.id == userData2.read('id'))
                                  // InkWell(
                                  //     onTap: (){
                                  //       final PostLikeController postOnecontroller = Get.find();
                                  //       postOnecontroller.delete(
                                  //           '${post!.user.id}','${post.id}'
                                  //
                                  //       );
                                  //
                                  //     },
                                  //     child: Icon(Icons.delete)),
                                  //     Delete2Post(postId: post.id.toString())
                                  // else
                                  //   const SavePost(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        15.heightBox,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            maxLines: null,
                            softWrap: true,
                            '${item[index].text}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Divider(),
                        // PostActionsRow(
                        //   postidforlike: item[index].id,
                        //   likecount: post.likecount,
                        //   pressLike: () async {
                        //
                        //
                        //
                        //
                        //     final PostLikeController postOnecontroller = Get.find();
                        //     postOnecontroller.setLike(post.id, '${post.likecount}');
                        //     print('post.id${post.id}');
                        //   },
                        //   pressComment: pressComment,
                        //   pressShare: () {
                        //     final String postContent = post.text;
                        //     onSharePressed(postContent);
                        //   },
                        //   commentsCount: post.commentsCount,
                        // ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context,index)=>SizedBox(height: 10,),
                itemCount: item!.length);
          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}