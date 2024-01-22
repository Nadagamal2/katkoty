import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/list.dart';
import '../view/El_Azqar/widget/custom_dialog.dart';

class ElesthferController extends GetxController {
  var elesthferList = <Elesthfer>[].obs;
  final MyDialogController myDialogController = Get.put(MyDialogController());

  final ElesthferStorage _elesthferStorage = ElesthferStorage();

  double get savedPercentage => _elesthferStorage.savedPercentage;
  @override
  void onInit() {
    elesthferList.assignAll(
        elesthfer.map((elesthfer) => Elesthfer(name: elesthfer.name)).toList());
    super.onInit();
  }

  void updateReadStatus(int index, bool value) {
    elesthferList[index].read = value;
    updatePercentage(); 
    update();
  }

  void updatePercentage() {
    int readCount = elesthferList.where((elesthfer) => elesthfer.read).length;
    double percentage = readCount / elesthferList.length * 100;
    savePercentage(percentage);
    update();
  }

  void savePercentage(double percentage) {
    _elesthferStorage.savePercentage(percentage);
  }

  void saveEnteredText(String text) {
    _elesthferStorage.saveEnteredText(text);
  }

  String getEnteredText() {
    return _elesthferStorage.getEnteredText();
  }
}

class Elesthfer {
  final String name;
  bool read;

  Elesthfer({required this.name, this.read = false});
}

class ElesthferStorage {
  final _storageElesthfer = GetStorage();
  final String percentageKeyElesthfer = "Elesthferpercentage";

  double get savedPercentage => _storageElesthfer.read(percentageKeyElesthfer) ?? 0.0;

  void savePercentage(double percentage) {
    print('Saving percentage: $percentage');
    Future<void> success = _storageElesthfer.write(percentageKeyElesthfer, percentage);
    print('Write success: $success');
  }

  void saveEnteredText(String text) {
    _storageElesthfer.write("entered_text", text);
  }

  String getEnteredText() {
    return _storageElesthfer.read("entered_text") ?? "";
  }
}
