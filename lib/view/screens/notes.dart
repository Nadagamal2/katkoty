import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/models/fadfada_model.dart';
import 'package:katkoty/service/shared_preference/user_preference.dart';
import 'package:katkoty/utils/color.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_appBar.dart';
import 'package:katkoty/view/screens/edit_notes.dart';
import 'package:http/http.dart' as http;

import '../../controller/add_note_controller.dart';
import '../../controller/get_fadfda_controller.dart';
import '../../controller/note_controller.dart';
import '../../service/services/fadfda_service.dart';
import 'add_note.dart';
class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();

}
final userData2 = GetStorage();
Future<List<GetFadfdaModel>?> fetchData() async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://katkoty-app.com/admin/api/get_fadfada.php?user_id=${userData2.read('id')}'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {

    Map<String, dynamic> jsonResponse =
    json.decode(await response.stream.bytesToString());
    print(jsonResponse);

    List  posts = jsonResponse['posts'];


   return posts.map((post) => GetFadfdaModel.fromJson(post)).toList();


  } else {
    print(response.reasonPhrase);
  }
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        title: 'ركن الكتكوت الدافئ'.tr,
        onPressed: () {
          Get.back();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<List<GetFadfdaModel>?>(
                future: fetchData(),
                builder: (context,snap){
                  if(snap.hasData){
                    List<GetFadfdaModel>? item = snap.data;
                    return ListView.builder(
                      itemCount: item!.length,
                      itemBuilder: (BuildContext context, index) {

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppbarColor),
                          ),
                          child: ListTile(
                            title: Text(item[index].text),
                            onTap: () {
                              //controller.showNoteContentDialog(context, fadfda.text);
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: ()async {
                                    await Get.to(EditNote( id: '${item[index].id}',));

                                    // Handle the action when tapping on the note
                                    // controller.openNote(note);
                                    // controller.showNoteContentDialog(context, EditNoteController.EditNoteControl.text,fadfda.id.toString());
                                    // await FadfdaApiService().EditFormData(
                                    //     userId: userData2.read('id') ,
                                    //     id:fadfda.id.toString(), text: '${EditNoteControl.toString()}' );
                                    // controller.editNote(
                                    //   userId: UserPreferences.getUserid(),
                                    //   noteId: fadfda.id.toString(),
                                    //   newText: fadfda.text,
                                    // );
                                  },
                                  child: const Icon(
                                    Icons.edit_note,
                                    color: AppbarColor,
                                    size: 25,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                InkWell(
                                  onTap: ()async {
                                    await FadfdaApiService().DeleteFormData(
                                        userId: userData2.read('id') ,
                                        id:item[index].id.toString() );
                                    // Handle the action when tapping on the delete icon
                                    // _showDeleteConfirmationDialog(context, note);
                                  },
                                  child: const Icon(
                                    CupertinoIcons.trash_fill,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
           await Get.to(()=>const AddNote());
          //  controller.getNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class Notes extends  {
//   final UserFadfdaController fadfdaController = Get.put(UserFadfdaController());
//   final userData2 = GetStorage();
//   Notes({Key? key}) : super(key: key);
//   void _showDeleteConfirmationDialog(BuildContext context, FadfadaModel note) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: const Center(child: Text("حذف الفضفضه")),
//           content: const Text("هل أنت متأكد من حذف هذه الفضفضه"),
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 119,
//                   height: 43,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     color: const Color(0xFFF6C116),
//                   ),
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text(
//                       "رجوع",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Container(
//                   width: 119,
//                   height: 43,
//                   decoration: ShapeDecoration(
//                     color: const Color.fromARGB(255, 255, 255, 255),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       side: const BorderSide(color: Colors.red),
//                     ),
//                   ),
//                   child: TextButton(
//
//                       onPressed: () async {
//                         await FadfdaApiService().DeleteFormData(
//                             userId: userData2.read('id') ,
//                             id:note.id.toString() );
//
//                       // },
//                       // controller.deleteNote(
//                       //     userId: UserPreferences.getUserid(),
//                       //     noteId: note.id.toString());
//                       // Navigator.of(context).pop();
//                     },
//                     child: const Text(
//                       "حذف",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.red,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// //  final AddNoteController EditNoteController = Get.put(AddNoteController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'ركن الكتكوت الدافئ'.tr,
//         onPressed: () {
//           Get.back();
//         },
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ListView.builder(
//                 itemCount: fadfdaController.fadfda.length,
//                 itemBuilder: (BuildContext context, index) {
//                   final fadfda = fadfdaController.fadfda[index];
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 10),
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(color: AppbarColor),
//                     ),
//                     child: ListTile(
//                       title: Text(fadfda.text),
//                       onTap: () {
//                         //controller.showNoteContentDialog(context, fadfda.text);
//                       },
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           InkWell(
//                             onTap: ()async {
//                               await Get.to(EditNote( id: '${fadfda.id.toString()}',));
//
//                               // Handle the action when tapping on the note
//                               // controller.openNote(note);
//                              // controller.showNoteContentDialog(context, EditNoteController.EditNoteControl.text,fadfda.id.toString());
//                               // await FadfdaApiService().EditFormData(
//                               //     userId: userData2.read('id') ,
//                               //     id:fadfda.id.toString(), text: '${EditNoteControl.toString()}' );
//                               // controller.editNote(
//                               //   userId: UserPreferences.getUserid(),
//                               //   noteId: fadfda.id.toString(),
//                               //   newText: fadfda.text,
//                               // );
//                             },
//                             child: const Icon(
//                               Icons.edit_note,
//                               color: AppbarColor,
//                               size: 25,
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           InkWell(
//                             onTap: ()async {
//                               await FadfdaApiService().DeleteFormData(
//                                   userId: userData2.read('id') ,
//                                   id:fadfda.id.toString() );
//                               // Handle the action when tapping on the delete icon
//                               // _showDeleteConfirmationDialog(context, note);
//                             },
//                             child: const Icon(
//                               CupertinoIcons.trash_fill,
//                               size: 20,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Get.to (AddNote());
//         //  controller.getNotes();
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
// AnimatedFloatingActionButton(
// fabButtons: <Widget>[controller.float1(), controller.float2()],
// key: controller.key,
// colorStartAnimation: Colors.amber,
// colorEndAnimation: Colors.red,
// animatedIconData: AnimatedIcons.menu_close //To principal button
// )