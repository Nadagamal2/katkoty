import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../view/El_Azqar/widget/custom_dialog.dart';
import '../utils/list.dart';

class TreasuresController extends GetxController {
  var treasuresList = <Treasures>[].obs;
  // Commented out this line because you don't seem to be using MyDialogController here
  // final MyDialogController myDialogController = Get.put(MyDialogController());

  final TreasuresStorage _treasuresStorage = TreasuresStorage();

  double get savedPercentage => _treasuresStorage.savedPercentage;

  @override
  void onInit() {
    treasuresList.assignAll(
        elzkerT.map((treasures) => Treasures(name: treasures.name)).toList());
    super.onInit();
  }

  void updateReadStatus(int index, bool value) {
    treasuresList[index].read = value;
    updatePercentage();
    update();
  }

  void updatePercentage() {
    int readCount = treasuresList.where((treasures) => treasures.read).length;
    double percentage = readCount / treasuresList.length * 100;
    savePercentage(percentage);
    update();
  }

  void savePercentage(double percentage) {
    _treasuresStorage.savePercentage(percentage);
  }

  void saveEnteredText(String text) {
    _treasuresStorage.saveEnteredText(text);
  }

  String getEnteredText() {
    return _treasuresStorage.getEnteredText();
  }
}

class Treasures {
  final String name;
  bool read;

  Treasures({required this.name, this.read = false});
}

class TreasuresStorage {
  final _storageTreasures = GetStorage();
  final String percentageKeyTreasures = "treasuresPercentage";

  double get savedPercentage =>
      _storageTreasures.read(percentageKeyTreasures) ?? 0.0;

  void savePercentage(double percentage) {
    _storageTreasures.write(percentageKeyTreasures, percentage);
  }

  void saveEnteredText(String text) {
    _storageTreasures.write("entered_text", text);
  }

  String getEnteredText() {
    return _storageTreasures.read("entered_text") ?? "";
  }
}
