import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';

import '../db/model/tasks_model.dart';
import '../utils/color.dart';

class NotesController extends GetxController {
  final zaghrotaPlayer = AudioPlayer();
  static const _boxName = 'notesBox';
  final _notes = <TaskModel>[].obs;
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();
  List<TaskModel> get notes => _notes.toList();

  @override
  void onInit() async {
    super.onInit();
    await GetStorage.init(_boxName);
    _loadNotes();
  }

  @override
  void onClose() {
    super.onClose();
    _saveNotes();
    zaghrotaPlayer.stop();
    zaghrotaPlayer.dispose();
  }

  onTaskDoneDialog() async {
    return Get.defaultDialog(
        title: 'task_done'.tr,
        textConfirm: 'شكرا'.tr,
        confirmTextColor: Colors.black,
        cancelTextColor: Colors.black,
        radius: 20,
        content: Column(
          children: [
            SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/giphy.gif')),
            Center(
              child: Text('task_done_msg'.tr),
            ),
          ],
        ));
  }

  void addNote({
    required String name,
    required String subject,
    required String text,
  }) {
    final note = TaskModel(
      name: name,
      subject: subject,
      text: text,
    );
    _notes.add(note);
    _noteController.clear();
    _nameController.clear();
    _saveNotes();
  }

  void editNote({
    required String name,
    required String text,
    required int index,
  }) {
    final note = TaskModel(
      name: name,
      subject: _notes[index].text,
      text: text,
    );
    _notes.removeAt(index);
    _notes.insert(index, note);
    _saveNotes();
  }

  void deleteNoteAtIndex(int index) {
    _notes.removeAt(index);
    _saveNotes();
  }

  void _saveNotes() {
    final box = GetStorage(_boxName);
    final notesJson = _notes.map((note) => note.toJson()).toList();
    box.write('notes', notesJson);
    box.save();
  }

  void _loadNotes() {
    final box = GetStorage(_boxName);
    final notesJson = box.read<List<dynamic>>('notes') ?? [];
    _notes
        .assignAll(notesJson.map((json) => TaskModel.fromJson(json)).toList());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void playZaghrootaRingtone() async {
    zaghrotaPlayer.stop();
    await zaghrotaPlayer
        .setAudioSource(AudioSource.asset('assets/sounds/z.mp3'));
    zaghrotaPlayer.play();
    await Future.delayed(const Duration(seconds: 5));
    zaghrotaPlayer.stop();
  }

  void showAddNoteDialog(BuildContext context) {
    _nameController.clear();
    _noteController.clear();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*    IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                  size: 30,
                ),
                onPressed: () {
                  _nameController.clear();
                  _noteController.clear();
                  Get.back();
                },
              ), */
              FittedBox(
                child: Text(
                  "إضافة مهام جديدة".tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color.fromARGB(154, 158, 158, 158),
                ),
              ),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'إضافة المهمة'.tr,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color.fromARGB(154, 158, 158, 158),
                ),
              ),
              child: TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: 'إضافة ملاحظة'.tr,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: AppbarColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              onPressed: () {
                final name = _nameController.text.trim();
                final text = _noteController.text.trim();
                if (name.isNotEmpty && text.isNotEmpty) {
                  addNote(
                    name: name,
                    subject: text,
                    text: text,
                  );
                  _nameController.clear();
                  _noteController.clear();
                  Get.back();
                }
              },
              child: const Text('إضافة مهمة'),
            ),
          )
        ],
      ),
    );
  }

  void showNoteDialog(BuildContext context, String text, int index) {
    final notesController = Get.find<NotesController>();

    final nameController = TextEditingController();
    final noteController = TextEditingController();

    nameController.text = notesController.notes[index].name;
    noteController.text = text;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*  IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                  size: 35,
                ),
                onPressed: () {
                  Get.back();
                },
              ), */
              Spacer(),
              Text(
                "تعديل مهمة ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color.fromARGB(255, 212, 211, 211))),
              child: TextFormField(
                onChanged: (value) {
                  nameController.text = value;
                },
                controller: nameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color.fromARGB(255, 212, 211, 211))),
              child: TextFormField(
                onChanged: (value) {
                  noteController.text = value;
                },
                controller: noteController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                maxLines: null,
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              onPressed: () {
                final name = nameController.text.trim();
                final noteText = noteController.text.trim();
                if (name.isNotEmpty && noteText.isNotEmpty) {
                  notesController.editNote(
                    name: name,
                    text: noteText,
                    index: index,
                  );
                  Get.back();
                  print(noteText);
                }
              },
              child: const Text('تعديل'),
            ),
          )
        ],
      ),
    );
  }
}
