import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/list.dart';
import '../view/El_Azqar/widget/custom_dialog.dart';

class PrayerController extends GetxController {
  var prayerList = <Prayer>[].obs;
  final MyDialogController myDialogController = Get.put(MyDialogController());

  final PrayerStorage _prayersStorage = PrayerStorage();

  double get savedPercentage => _prayersStorage.savedPercentage;

  @override
  void onInit() {
    prayerList.assignAll(
        prayers.map((prayers) => Prayer(name: prayers.name)).toList());
    super.onInit();
  }

  void updateReadStatus(int index, bool value) {
    prayerList[index].read = value;
    updatePercentage();
    update();
  }

  void updatePercentage() {
    int readCount = prayerList.where((prayers) => prayers.read).length;
    double percentage = readCount / prayerList.length * 100;
    savePercentage(percentage);
    update();
  }

  void savePercentage(double percentage) {
    _prayersStorage.savePercentage(percentage);
  }

  void saveEnteredText(String text) {
    _prayersStorage.saveEnteredText(text);
  }

  String getEnteredText() {
    return _prayersStorage.getEnteredText();
  }
}

class Prayer {
  final String name;
  bool prayed;
  bool read;

  Prayer({required this.name, this.prayed = false, this.read = false});
}

class PrayerStorage {
  final _storagePrayer = GetStorage();
  final String percentageKeyPrayer = "percentagePrayer";

  double get savedPercentage => _storagePrayer.read(percentageKeyPrayer) ?? 0.0;

  void savePercentage(double percentage) {
    print('Saving percentage: $percentage');
    Future<void> success =
        _storagePrayer.write(percentageKeyPrayer, percentage);
    print('Write success: $success');
  }

  void saveEnteredText(String text) {
    _storagePrayer.write("entered_text", text);
  }

  String getEnteredText() {
    return _storagePrayer.read("entered_text") ?? "";
  }
}
