import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChallangeController extends GetxController {
  static ChallangeController get to => Get.find();

  final listofUserchallenge = <String>[].obs;
  List<String> get list => listofUserchallenge;
  final listofUserstrongchallenge = <String>[].obs;
  List<String> get list2 => listofUserstrongchallenge;
  final completedChallenges = <int>[].obs;
  final completedChallenges2 = <int>[].obs;
  final incompletedChallenges = <int>[].obs;
  final incompletedChallenges2 = <int>[].obs;

  final TextEditingController newChallenge = TextEditingController();
  late GetStorage _box;

  @override
  void onInit() {
    super.onInit();
    _box = GetStorage('challengebox');
    _loadCompletedChallenges();
    loaduserList2();
    loaduserList();
    loadCompletedChallenges();
    loadCompletedChallenges2(); // Load challenge2 completed challenges
  }

  Future<void> loadCompletedChallenges() async {
    await _loadCompletedChallenges();
    update();
  }

  Future<void> loadCompletedChallenges2() async {
    final completed2 = _box.read('completed_challenges2');
    if (completed2 != null) {
      completedChallenges2.value = List<int>.from(completed2);
    }
  }

  @override
  void onClose() {
    super.onClose();
    _saveCompletedChallenges();
    _saveCompletedChallenges2(); // Save challenge2 completed challenges
  }

  Future<void> loaduserList() async {
    final listData = _box.read('myList');
    if (listData != null) {
      listofUserchallenge.value = List<String>.from(listData);
    }
    update();
  }

  Future<void> addItemToList(String item) async {
    listofUserchallenge.add(item);
    _box.write('myList', listofUserchallenge.toList());
    update();
  }

  Future<void> loaduserList2() async {
    final list2Data = _box.read('myList2');
    if (list2Data != null) {
      listofUserstrongchallenge.value = List<String>.from(list2Data);
    }
    update();
  }

  Future<void> addItemToList2(String item) async {
    listofUserstrongchallenge.add(item);
    _box.write('myList2', listofUserstrongchallenge.toList());
    update();
  }

  Future<void> _loadCompletedChallenges() async {
    final completed = _box.read('completed_challenges');
    if (completed != null) {
      completedChallenges.value = List<int>.from(completed);
    }
  }

  void completeChallenge(int index) {
    completedChallenges.add(index);
    _saveCompletedChallenges();
    update();
  }

  void completeChallenge2(int index) {
    completedChallenges2.add(index); // Add challenge2 completed challenge
    _saveCompletedChallenges2(); // Save challenge2 completed challenges
    update();
  }

  void incompleteChallenge(int index) {
    incompletedChallenges.add(index);
    _saveinCompletedChallenges();
    update();
  }

  void incompleteChallenge2(int index) {
    incompletedChallenges2.add(index);
    _saveinCompletedChallenges2();
    update();
  }

  // remove challenge

  void removecompleteChalleng2(int index) {
    completedChallenges2.remove(index);
    _saveCompletedChallenges2();
    update();
  }

  void removecompleteChallenge(int index) {
    completedChallenges.remove(index);
    _saveCompletedChallenges();
    update();
  }

  void removeincompleteChallenge(int index) {
    incompletedChallenges.remove(index);
    _saveinCompletedChallenges();
    update();
  }

  void removeincompleteChallenge2(int index) {
    incompletedChallenges2.remove(index);
    _saveinCompletedChallenges2();
    update();
  }

  //
  //check if is compelete
  bool isChallengeCompleted(int index) {
    return completedChallenges.contains(index);
  }

  bool isChallenge2Completed(int index) {
    return completedChallenges2
        .contains(index); // Check challenge2 completed challenge
  }

  bool isinChallengeCompleted(int index) {
    return incompletedChallenges.contains(index);
  }

  bool isinChallengeCompleted2(int index) {
    return incompletedChallenges2.contains(index);
  }

  //reset all challenge
  Future<void> resetChallenges() async {
    completedChallenges.clear();
    completedChallenges2.clear();
    incompletedChallenges.clear();
    incompletedChallenges2.clear();
    listofUserchallenge.clear();
    listofUserstrongchallenge.clear();
    _box.remove('completed_challenges');
    _box.remove('completed_challenges2');
    _box.remove('incompleted_challenges');
    _box.remove('incompleted_challenges2');
    update();
  }

  // save challenge
  Future<void> _saveCompletedChallenges() async {
    await _box.write('completed_challenges', completedChallenges.toList());
  }

  Future<void> _saveCompletedChallenges2() async {
    await _box.write('completed_challenges2',
        completedChallenges2.toList()); // Save challenge2 completed challenges
  }

  Future<void> _saveinCompletedChallenges() async {
    await _box.write('incompleted_challenges', incompletedChallenges.toList());
  }

  Future<void> _saveinCompletedChallenges2() async {
    await _box.write(
        'incompleted_challenges2', incompletedChallenges2.toList());
  }

  //
}
