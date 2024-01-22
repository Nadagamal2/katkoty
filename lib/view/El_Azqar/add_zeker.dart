/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_appBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/color.dart';
import 'widget/custom_Alert.dart';
import 'widget/shibha.dart';

class AddZeker extends StatefulWidget {
  const AddZeker({Key? key}) : super(key: key);

  @override
  State<AddZeker> createState() => _AddZekerState();
}

class _AddZekerState extends State<AddZeker> {
  final List<String> addedAzkarList = [];
  final TextEditingController _textEditingController = TextEditingController();
  bool showStaticCard = true;

  @override
  void initState() {
    super.initState();
    _loadSavedAzkarList();
  }

  Future<void> _loadSavedAzkarList() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAzkarList = prefs.getStringList('addedAzkarList');

    if (savedAzkarList != null) {
      setState(() {
        addedAzkarList.addAll(savedAzkarList);
        showStaticCard = savedAzkarList.isEmpty;
      });
    }
  }

  void _showAddCardDialog() async {
    final enteredText = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlertDialog();
      },
    );

    if (enteredText != null && enteredText.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        addedAzkarList.add(enteredText);
        showStaticCard = false;
      });

      prefs.setStringList('addedAzkarList', addedAzkarList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'إضافه الذكر',
        onPressed: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (showStaticCard) _buildStaticCard(),
            ...addedAzkarList.asMap().entries.map((entry) {
              int index = entry.key;
              String addedAzkar = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _buildCustomCard(addedAzkar, index),
              );
            }).toList(),
            const Sebhia(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCardDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStaticCard() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: Color.fromARGB(255, 226, 223, 223),
              width: 1.0,
            ),
          ),
          child: const ListTile(
            title: Center(
              child: Text(
                'قم بإضافة نص ذكر هنا',
                style: TextStyle(
                  fontSize: 22,
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomCard(String title, int index) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: Color.fromARGB(255, 226, 223, 223),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        addedAzkarList.removeAt(index);
                        if (addedAzkarList.isEmpty) {
                          showStaticCard = true;
                        }
                      });
                      SharedPreferences.getInstance().then((prefs) {
                        prefs.setStringList('addedAzkarList', addedAzkarList);
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              ListTile(
                title: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 35),
                    child: Text(
                      title,
                      maxLines: 5,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */