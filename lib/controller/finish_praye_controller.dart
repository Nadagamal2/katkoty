import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/list.dart';
import '../view/El_Azqar/widget/custom_dialog.dart';

class FinishPrayController extends GetxController {
  var finishPrayerList = <FinishPrayer>[].obs;
  final MyDialogController myDialogController = Get.put(MyDialogController());

  final FinishPrayStorage _finishPrayerStorage = FinishPrayStorage();

  double get savedPercentage => _finishPrayerStorage.savedPercentage;

  @override
  void onInit() {
    finishPrayerList.assignAll(finishPrayer
        .map((finishPrayer) => FinishPrayer(name: finishPrayer.name))
        .toList());
    super.onInit();
  }

  void updateReadStatus(int index, bool value) {
    finishPrayerList[index].read = value;
    updatePercentage(); // update the percentage immediately after updating the read status
    update();
  }

  void updatePercentage() {
    int readCount =
        finishPrayerList.where((finishPrayer) => finishPrayer.read).length;
    double percentage = readCount / finishPrayerList.length * 100;
    savePercentage(percentage);
    update();
  }

  void savePercentage(double percentage) {
    _finishPrayerStorage.savePercentage(percentage);
  }

  void saveEnteredText(String text) {
    _finishPrayerStorage.saveEnteredText(text);
  }

  String getEnteredText() {
    return _finishPrayerStorage.getEnteredText();
  }
}

class FinishPrayer {
  final String name;
  bool read;

  FinishPrayer({required this.name, this.read = false});
}

class FinishPrayStorage {
  final _storage = GetStorage();
  final String percentageKey = "percentage";

  double get savedPercentage => _storage.read(percentageKey) ?? 0.0;

  void savePercentage(double percentage) {
    print('Saving percentage: $percentage');
    Future<void> success = _storage.write(percentageKey, percentage);
    print('Write success: $success');
  }

  void saveEnteredText(String text) {
    _storage.write("entered_text", text);
  }

  String getEnteredText() {
    return _storage.read("entered_text") ?? "";
  }
}
