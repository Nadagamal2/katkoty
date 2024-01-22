/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/db/model/sibha_Model.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_dialog.dart';

class ElazkarController extends GetxController {
  final MyDialogController myDialogController = Get.put(MyDialogController());
  final box = GetStorage();
  List<SibhaItemModel> azkarList = [];
  final storageKey = 'mySpecificAzkarListKey';
  final enteredTextKey = 'enteredText';

  @override
  void onInit() {
    super.onInit();
    _loadAzkarListFromStorage();
    showDefaultDialog();
  }

  Future<void> _loadAzkarListFromStorage() async {
    final savedAzkarListData = await box.read<List<dynamic>>(storageKey) ?? [];
    azkarList = savedAzkarListData
        .map((item) => SibhaItemModel.fromJson(item))
        .toList();
    update(); // Notify the UI that the azkarList has changed
  }

  Future<void> _updateAzkarListInStorage() async {
    final data = azkarList.map((item) => item.toJson()).toList();
    await box.write(storageKey, data);
  }

  void removeCard(int index) {
    azkarList.removeAt(index);
    _updateAzkarListInStorage();
    update(); // Notify the UI that the card has been removed
  }

 

  void showDefaultDialog() {
    final bool hasShownDialoge =
        box.read<bool>('hasShownDialogeazkar') ?? false;
    if (!hasShownDialoge) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        myDialogController.showDefaultDialog(
          title: "{ألا بذكر الله تطمئن القلوب}",
          contant: const Text(
            'من باب التشجيع على الذِكر وليس التخصيص في القسم ده هيكون ليك وِرد من الذِكر تردده 50 مرة يومياً، كل يوم ذِكر مختلف هتلاقيه هيعينك علي الطاعة يا كتكوتي وتقدر تضيف الأذكار اللي تحبها 💛",',
          ),
        );
      });
      box.write('hasShownDialogeazkar', true);
    }
  }
}
 */