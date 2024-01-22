import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/db/model/sibha_Model.dart';
import 'package:katkoty/service/services/changedZqer.dart';
import 'package:katkoty/utils/color.dart';
import 'package:katkoty/utils/strings.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_card_home.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_utton.dart';
import 'package:katkoty/view/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db/model/changeZqer.dart';
import 'elzeker.dart';
import 'widget/custom_Alert.dart';
import 'widget/custom_appBar.dart';
import 'widget/custom_dialog.dart';
import 'widget/shibha.dart';

class Mesbaha extends StatefulWidget {
  final SibhaItemModel? selectedSibhaItem;

  const Mesbaha({Key? key, this.selectedSibhaItem}) : super(key: key);

  @override
  State<Mesbaha> createState() => _MesbahaState();
}

class _MesbahaState extends State<Mesbaha> {
  late Future<SibhaResponseModel> _futureSibhaResponseModel;
  late String enteredText;
  SibhaItemModel cachedSibhaData =
      SibhaItemModel(title: '', body: '', count: 0);

  @override
  void initState() {
    super.initState();
    _loadCachedData();
    _futureSibhaResponseModel = fetchSibhaData();
  }

  Future<void> _loadCachedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedData = prefs.getString('cachedSibhaData') ?? '';
    setState(() {
      cachedSibhaData = SibhaItemModel(title: cachedData, body: '', count: 0);
    });
  }

  Future<void> _saveCachedData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cachedSibhaData', data);
  }

  @override
  Widget build(BuildContext context) {
    final GetStorage box = GetStorage();
    final MyDialogController myDialogController = Get.put(MyDialogController());
    bool hasShownDialoge = box.read<bool>('hasShownDialogeazkar') ?? false;
    if (!hasShownDialoge) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        myDialogController.showDefaultDialog(
            title: "{ألا بذكرالله تطمئن القلوب}",
            contant: const Text(
              mesbhaDialog,
              textAlign: TextAlign.center,
            ));
      });
      box.write('hasShownDialogeazkar', true);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'وِرد الذكر',
        onPressed: () {
          Get.to(() =>   Home());
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            FutureBuilder<SibhaResponseModel>(
              future: _futureSibhaResponseModel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  if (cachedSibhaData.title.isNotEmpty) {
                    return CardWidgetHome(dataSibha: cachedSibhaData);
                  }
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  SibhaItemModel dataSibha;
                  if (widget.selectedSibhaItem != null) {
                    // Convert SibhaHomeItemModel to SibhaItemModel
                    dataSibha = SibhaItemModel(
                      title: widget.selectedSibhaItem!.title,
                      body: widget.selectedSibhaItem!.body,
                      count: widget.selectedSibhaItem!.count,
                    );
                  } else if (snapshot.data!.sibha.isNotEmpty) {
                    final firstSibhaItem = snapshot.data!.sibha[0];
                    dataSibha = SibhaItemModel(
                      title: firstSibhaItem.title,
                      body: firstSibhaItem.body,
                      count: firstSibhaItem.count,
                    );
                    _saveCachedData(dataSibha.body); // Save fetched data
                  } else {
                    return const Text('No data available');
                  }
                  return CardWidgetHome(dataSibha: dataSibha);
                } else {
                  return const Text('No data available');
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            const Sebhia(),
            Row(
              children: [
                const Spacer(),
                CustomTextButton(
                  borderRadius: 10,
                  color: buttons,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(onSave: (text) {
                          enteredText = text; // Store the entered text
                          Get.to(() => ElazkarScreenMesbha(
                                enteredText:
                                    enteredText, // Pass the entered text
                              ));
                        });
                      },
                    );
                  },
                  text: 'إضافة ذكر',
                  testSize: 16,
                ),
                const Spacer(
                  flex: 4,
                ),
                CustomTextButton(
                  borderRadius: 10,
                  color: buttons,
                  onPressed: () {
                    Get.to(() => const ElazkarScreenMesbha());
                  },
                  text: 'الأذكار',
                  testSize: 16,
                ),
                const Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }
}
