import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/list.dart';

class ElazkarController extends GetxController {
  var elazkarTwoList = <Elazkar>[].obs;

  final ElazkarStorage _elazkarStorage = ElazkarStorage();

  double get savedPercentage => _elazkarStorage.savedPercentage;

  @override
  void onInit() {
    elazkarTwoList.assignAll(
        elzker.map((elazkar) => Elazkar(name: elazkar.name)).toList());
    super.onInit();
  }

  void updateReadStatus(int index, bool value) {
    elazkarTwoList[index].read = value;
    updatePercentage();
    update();
  }

  void updatePercentage() {
    int readCount = elazkarTwoList.where((elazkar) => elazkar.read).length;
    double percentage = readCount / elazkarTwoList.length * 100;
    savePercentage(percentage);
    update();
  }

  void savePercentage(double percentage) {
    _elazkarStorage.savePercentage(percentage);
  }

  void saveEnteredText(String text) {
    _elazkarStorage.saveEnteredText(text);
  }

  String getEnteredText() {
    return _elazkarStorage.getEnteredText();
  }
}

class Elazkar {
  final String name;
  bool read;

  Elazkar({required this.name, this.read = false});
}

class ElazkarStorage {
  final _storageElazkar = GetStorage();
  final String percentageKeyElazkar = "ElazkarPercentage";

  double get savedPercentage =>
      _storageElazkar.read(percentageKeyElazkar) ?? 0.0;

  void savePercentage(double percentage) {
    _storageElazkar.write(percentageKeyElazkar, percentage);
  }

  void saveEnteredText(String text) {
    _storageElazkar.write("entered_text", text);
  }

  String getEnteredText() {
    return _storageElazkar.read("entered_text") ?? "";
  }
}
