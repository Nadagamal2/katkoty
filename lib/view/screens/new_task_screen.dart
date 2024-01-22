import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/controller/new_taskcontroller.dart';
import 'package:katkoty/utils/color.dart';
import 'package:katkoty/utils/images.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_appBar.dart';

import '../../utils/strings.dart';
import '../El_Azqar/widget/custom_dialog.dart';

class NewTaskScreen extends StatelessWidget {
  final NotesController _notesController;

  NewTaskScreen({Key? key})
      : _notesController = Get.put(NotesController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetStorage box = GetStorage();

    final MyDialogController myDialogController = Get.put(MyDialogController());
    bool hasShownDialoge = box.read<bool>('hasShownDialogetask') ?? false;
    if (!hasShownDialoge) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        myDialogController.showDefaultDialog(
            contant: const Text(
          taskWelcom,
          textAlign: TextAlign.center,
        ));
      });
      box.write('hasShownDialogetask', true);
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'أشطـر كتكوت'.tr,
        onPressed: () {
          Get.back();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _notesController.showAddNoteDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: _notesController.notes.length,
                    itemBuilder: (context, index) {
                      final note = _notesController.notes[index];
                      return Obx(() => Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: AppbarColor)),
                            child: ListTile(
                              title: Text(_notesController.notes[index].name),
                              subtitle:
                                  Text(_notesController.notes[index].text),
                              onTap: () => _notesController.showNoteDialog(
                                  context, note.text, index),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        _notesController.showNoteDialog(
                                            context, note.text, index);
                                      },
                                      child: Image.asset(edit)),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _showDeleteConfirmationDialog(
                                          context, index);
                                    },
                                    child: const Icon(
                                      CupertinoIcons.trash_fill,
                                      size: 24,
                                      color:
                                          Colors.red, // Set the desired color
                                    ),
                                  )
                                ],
                              ),
                              leading: IconButton(
                                  onPressed: () async {
                                    myDialogController.showDefaultDialog(
                                        title: 'خلصت المهمة',
                                        contant: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                'assets/images/taskdone.png'),
                                            const Text('عاش يا أشطر كتكوت💛')
                                          ],
                                        ));
                                    _notesController.playZaghrootaRingtone();
                                    _notesController.deleteNoteAtIndex(index);
                                  },
                                  icon: const Icon(Icons.done)),
                            ),
                          ));
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Center(child: Text("حذف المهمة")),
          content: const Text("هل أنت متأكد من حذف هذه المهمة"),
          actions: [
            Row(
              children: [
                const Spacer(),
                Container(
                  width: 119,
                  height: 43,
                  padding: const EdgeInsets.only(top: 3),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF6C116),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text("رجوع",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 119,
                  height: 43,
                  padding: const EdgeInsets.only(top: 3),
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(
                          color: Colors.red), // Add a red border
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _notesController
                          .deleteNoteAtIndex(index); // Call the delete method
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text("حذف",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        );
      },
    );
  }
}
