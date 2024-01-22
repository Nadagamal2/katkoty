import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_appBar.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_card.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_dialog.dart';
import '../../db/model/sibha_Model.dart';
import '../../service/services/sibhaMethod.dart';
import 'mesbaha.dart';

class ElazkarScreenMesbha extends StatefulWidget {
  final String? enteredText;

  const ElazkarScreenMesbha({Key? key, this.enteredText}) : super(key: key);

  @override
  State<ElazkarScreenMesbha> createState() => _ElazkarScreenMesbhaState();
}

class _ElazkarScreenMesbhaState extends State<ElazkarScreenMesbha> {
  final MyDialogController myDialogController = Get.put(MyDialogController());
  final box = GetStorage();
  List<SibhaItemModel> azkarList = [];
  final storageKey = 'mySpecificAzkarListKey';
  final enteredTextKey = 'enteredText';
  List<String> enteredTexts = [];

  @override
  void initState() {
    super.initState();
    _loadAzkarListFromStorage();
    _loadEnteredTextFromStorage();
    if (widget.enteredText != null && widget.enteredText!.isNotEmpty) {
      addEnteredText(widget.enteredText!);
    }
  }

  Future<void> _loadAzkarListFromStorage() async {
    final savedAzkarListData = box.read<List<dynamic>>(storageKey) ?? [];
    setState(() {
      azkarList = savedAzkarListData
          .map((item) => SibhaItemModel.fromJson(item))
          .toList();
    });
  }


  Future<void> _loadEnteredTextFromStorage() async {
    final storedEnteredTexts = box.read<List<String>>(enteredTextKey) ?? [];
    setState(() {
      enteredTexts = storedEnteredTexts; 
    });
  }

  void addEnteredText(String text) {
    if (text.isNotEmpty) {
      setState(() {
        enteredTexts.add(text); 
        box.write(enteredTextKey, enteredTexts); 
      });
    }
  }

  void _removeEnteredText(int index) {
    setState(() {
      enteredTexts.removeAt(index);
      box.write(enteredTextKey, enteredTexts); 
    });
  }

  @override
  Widget build(BuildContext context) {
    final savedSibhaData = box.read('sibhaData');
    return Scaffold(
      appBar: CustomAppBar(
        title: 'الأذكار',
        onPressed: () {
          Get.to(() => const Mesbaha(
                selectedSibhaItem: null,
              ));
        },
      ),
      body: FutureBuilder<SibhaModel>(
        future: fetchSibhaData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError && savedSibhaData == null) {
            return const Center(
              child: Text(
                ' Please check your internet connection.',
                style: TextStyle(fontSize: 16.0),
              ),
            );
          } else {
            SibhaModel sibhaData;
            if (snapshot.hasData) {
              sibhaData = snapshot.data!;
              box.write('sibhaData', sibhaData.toJson());
            } else {
              sibhaData = SibhaModel.fromJson(savedSibhaData);
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (var azkarItem in azkarList.asMap().entries)
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => Mesbaha(
                            selectedSibhaItem: azkarItem.value,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CardWidget(
                          dataSibha: azkarItem.value,
                        ),
                      ),
                    ),
                  for (var sibhaItem in sibhaData.sibha)
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => Mesbaha(
                            selectedSibhaItem: sibhaItem,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CardWidget(
                          dataSibha: sibhaItem,
                        ),
                      ),
                    ),
                  for (var index = 0; index < enteredTexts.length; index++)
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => Mesbaha(
                                selectedSibhaItem: SibhaItemModel(
                                  title: '',
                                  body: enteredTexts[index],
                                  count: 50,
                                ),
                              ),
                            );
                          },
                          child: CardWidget(
                            dataSibha: SibhaItemModel(
                              title: '',
                              body: enteredTexts[index],
                              count: 50,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                _removeEnteredText(index);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
