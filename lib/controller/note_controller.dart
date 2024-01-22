import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/db/model/deleteFadfada.dart';
import 'package:katkoty/models/fadfada_model.dart';
import 'package:katkoty/service/services/deleteFadfada.dart';
import 'package:katkoty/service/services/editiFadFadada.dart';

import '../service/services/fadfda_service.dart';
import '../view/widgets/custom_note_textForm.dart';

class NoteController extends GetxController {
  AppDatabase appDatabase = AppDatabase();
  RxList notes = [].obs;
  final DeleteFadfadaService _deleteService = Get.put(DeleteFadfadaService());
  final EditService _editService = Get.put(EditService());

  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();

  Widget float1() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed('add_note');
      },
      heroTag: "Text Note",
      tooltip: 'Text Note',
      child: const Icon(Icons.edit),
    );
  }

  Widget float2() {
    return FloatingActionButton(
      onPressed: () {
        // Get.toNamed('add_voice_note');
      },
      heroTag: "Voice Note",
      tooltip: 'Voice Note',
      child: const Icon(Icons.mic),
    );
  }

  Future<void> editNote({
    required String userId,
    required String noteId,
    required String newText,
  }) async {
    try {
      final result = await _editService.editItem(
        userId: userId,
        itemId: noteId,
        text: newText,
      );
      if (result.success) {
        Get.snackbar('Success', result.message);
      } else {
        Get.snackbar('Error', result.message, backgroundColor: Colors.red);
      }
    } catch (e) {
      print('Error editing note: $e');
      Get.snackbar('Error', 'Failed to edit note', backgroundColor: Colors.red);
    }
  }

  Future<void> deleteNote(
      {required String userId, required String noteId}) async {
    try {
      final result =
          await _deleteService.deleteItem(userId: userId, itemId: noteId);
      if (result.success) {
        notes.removeWhere((note) => note.id == noteId);

        Get.snackbar('Success', result.message);
      } else {
        Get.snackbar('Error', result.message, backgroundColor: Colors.red);
      }
    } catch (e) {
      print('Error deleting note: $e');
      Get.snackbar('Error', 'Failed to delete note',
          backgroundColor: Colors.red);
    }
  }
  /*  deleteNote(FadfadaModel note) async {
    await appDatabase.delete(note);
    getNotes();
  } */

  // openNote(FadfadaModel note) {
  //   TextEditingController noteEditingController = TextEditingController();
  //   noteEditingController.text = note.note ?? '';
  //
  //   return Get.dialog(AlertDialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //     actions: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           OutlinedButton(
  //             style: ButtonStyle(
  //               backgroundColor: const MaterialStatePropertyAll(Colors.green),
  //               shape: MaterialStateProperty.all(
  //                 RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(30.0),
  //                 ),
  //               ),
  //             ),
  //             onPressed: () {
  //               note.note = noteEditingController.text;
  //               updateNote(note);
  //               Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
  //             },
  //             child: Text(
  //               "حفظ التعديل".tr,
  //               style: const TextStyle(color: Colors.white),
  //             ),
  //           ),
  //           const SizedBox(
  //             width: 10,
  //           ),
  //           Container(
  //             width: 105,
  //             height: 33,
  //             decoration: ShapeDecoration(
  //               color: const Color.fromARGB(255, 255, 255, 255),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(25),
  //                 side: const BorderSide(color: Colors.red), // Add a red border
  //               ),
  //             ),
  //             child: TextButton(
  //               onPressed: () {
  //                 Get.back();
  //               },
  //               child: const Text(
  //                 "إلغاء",
  //                 style: TextStyle(
  //                   color: Colors.red,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       )
  //     ],
  //     title: const Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               /*  IconButton(
  //                 icon: const Icon(
  //                   Icons.cancel,
  //                   color: Colors.redAccent,
  //                 ),
  //                 onPressed: () {
  //                   Get.back();
  //                 },
  //               ), */
  //               Spacer(),
  //               FittedBox(
  //                 child: Text(
  //                   'تعديل فضفضة',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //               ),
  //               Spacer(),
  //             ],
  //           ),
  //           SizedBox(
  //             width: 30,
  //           )
  //         ],
  //       ),
  //     ),
  //     content: SingleChildScrollView(
  //       child: SizedBox(
  //         // height: 200,
  //         width: 200,
  //         child: Column(
  //           children: [
  //             SingleChildScrollView(
  //               child: TextField(
  //                 controller: noteEditingController,
  //                 textAlign: TextAlign.right,
  //                 maxLines: 3,
  //               ),
  //             ),
  //             /*  ElevatedButton(
  //               onPressed: () {
  //                 note.note = noteEditingController.text;
  //                 updateNote(note);
  //                 Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
  //               },
  //               child: Text('حفظ التعديل'),
  //             ), */
  //           ],
  //         ),
  //       ),
  //     ),
  //   ));
  // }
  //
  // void updateNote(FadfadaModel note) async {
  //   await appDatabase.update(note);
  //   getNotes();
  // }
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   getNotes();
  // }
  //
  // void getNotes() {
  //   appDatabase.getAllFadfada().then((value) {
  //     // notes.clear();
  //     notes.addAll(value);
  //   });
  // }
  TextEditingController EditNoteControl = TextEditingController();
  GlobalKey<FormState> addNoteKey = GlobalKey<FormState>();
  final userData2 = GetStorage();

  void showNoteContentDialog(BuildContext context, String? noteContent,String id) {
    if (noteContent != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Center(child: Text(" الفضفضة")),
            content: SingleChildScrollView(
              child:   Form(
                key: addNoteKey,
                child: CustomNoteTextFormField(
                  controller: EditNoteControl ,

                   maxLines: 20,
                  maxLength: 5000,
                  validator: (String? value) =>
                  value!.isEmpty ? 'اكتب حاجه الاول'.tr : null,
                ),
              ),
            ),
            actions: [
              InkWell(
                onTap: ()async {

                  await FadfdaApiService().EditFormData(
                      userId: userData2.read('id') ,
                      id:id, text: '${noteContent}' );
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      width: 119,
                      height: 35,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF6C116),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // Add border radius
                        ),
                      ),
                      child: const SizedBox(
                        width: 69,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  'حفظ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
