import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/list.dart';
import '../view/El_Azqar/widget/custom_dialog.dart';

class QuranController extends GetxController {
  var quranList = <Quran>[].obs;
  final MyDialogController myDialogController = Get.put(MyDialogController());

  final QuranStorage _quranStorage = QuranStorage();

  double get savedPercentage => _quranStorage.savedPercentage;
  
  @override
  void onInit() {
    quranList.assignAll(quran.map((quran) => Quran(name: quran.name)).toList());
    super.onInit();
  }

  void updateReadStatus(int index, bool value) {
    quranList[index].read = value;
    updatePercentage(); // update the percentage immediately after updating the read status
    update();
  }

  void updatePercentage() {
    int readCount = quranList.where((quran) => quran.read).length;
    double percentage1 = readCount / quranList.length * 100;
    savePercentage(percentage1);
    update();
  }

  void savePercentage(double percentage) {
    _quranStorage.savePercentage(percentage);
  }

  void saveEnteredText(String text) {
    _quranStorage.saveEnteredText(text);
  }

  String getEnteredText() {
    return _quranStorage.getEnteredText();
  }
}

class Quran {
  final String name;
  bool read;

  Quran({required this.name, this.read = false});
}

class QuranStorage {
  final _storageQuran = GetStorage();
  final String percentageKeyQuran = "Quranpercentage";

  double get savedPercentage => _storageQuran.read(percentageKeyQuran) ?? 0.0;

  void savePercentage(double percentage) {
    print('Saving percentage: $percentage');
    Future<void> success = _storageQuran.write(percentageKeyQuran, percentage);
    print('Write success: $success');
  }

  void saveEnteredText(String text) {
    _storageQuran.write("entered_text", text);
  }

  String getEnteredText() {
    return _storageQuran.read("entered_text") ?? "";
  }
}
