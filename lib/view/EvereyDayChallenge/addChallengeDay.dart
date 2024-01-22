import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/view/EvereyDayChallenge/challenge_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../utils/color.dart';
import '../El_Azqar/widget/custom_appBar.dart';
import '../El_Azqar/widget/custom_dialog.dart';
import '../El_Azqar/widget/custom_utton.dart';

class AddChallange extends StatefulWidget {
  const AddChallange({
    super.key,
  });

  @override
  State<AddChallange> createState() => _AddChallangeState();
}

class _AddChallangeState extends State<AddChallange> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _challengeController = TextEditingController();
  final ChallangeController controller = Get.put(ChallangeController());
  String? selectedDifficulty;
  final GetStorage box = GetStorage();

  @override
  void dispose() {
    _challengeController.dispose();
    controller.newChallenge.dispose();
    super.dispose();
  }

  final MyDialogController myDialogController = Get.put(MyDialogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          title: 'إضافة تحدى جديد',
          onPressed: () {
            Navigator.pop(context);
          }),
      body: Column(
        children: [
          30.heightBox,
          const Center(
            child: Text(
              'مستوى التحدي',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDifficulty = 'سهل';
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: 'سهل',
                      groupValue: selectedDifficulty,
                      onChanged: (value) {
                        setState(() {
                          selectedDifficulty = value.toString();
                        });
                      },
                    ),
                    const Text(
                      'سهل',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDifficulty = 'صعب';
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: 'صعب',
                      groupValue: selectedDifficulty,
                      onChanged: (value) {
                        setState(() {
                          selectedDifficulty = value.toString();
                        });
                      },
                    ),
                    const Text(
                      'صعب',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.heightBox,
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _challengeController,
                decoration: InputDecoration(
                  hintText: 'أدخل التحدي الأول...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppbarColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال التحدي';
                  }
                  return null;
                },
              ),
            ),
          ),
          20.heightBox,
          CustomTextButton(
            borderRadius: 25,
            width: 119,
            height: 43,
            color: Colors.white,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (selectedDifficulty == 'صعب') {
                  await controller.addItemToList('.');
                  await controller.addItemToList2(_challengeController.text);
                  Get.back();
                  myDialogController.showDefaultDialog(
                    contant: const Text(
                      'تم أضافة التحدي بنجاح يا كتكوتي 💛',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (selectedDifficulty == 'سهل') {
                  await controller.addItemToList2('.');
                  await controller.addItemToList(_challengeController.text);
                  Get.back();
                  myDialogController.showDefaultDialog(
                    contant: const Text(
                      'تم أضافة التحدي بنجاح يا كتكوتي 💛',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              }
            },
            testSize: 18,
            text: 'إضافة',
          ),
          20.heightBox,
          const Center(
            child: Text(
              ''' يمكنك إضافة تحدي جديد كما تشاء .. 
التحدي هو فرصة لإثبات قدراتك يا كتكوتى 💛''',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
