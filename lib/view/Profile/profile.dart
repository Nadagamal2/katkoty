import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katkoty/controller/home_controller.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_appBar.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../controller/auth_controller.dart';
import '../../service/shared_preference/user_preference.dart';
import '../../utils/color.dart';
import '../screens/Done_Screen.dart';
import '../widgets/date_widget.dart';
import 'package:katkoty/view/screens/menu.dart';
import 'package:http/http.dart' as http;
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _imageFile;
  final userData2 = GetStorage();
void EditImg(
    String img,
    )async{
  var request = http.MultipartRequest('POST', Uri.parse('https://katkoty-app.com/admin/api/change_profile_photo.php'));
  request.fields.addAll({
  'id': '${userData2.read('id')}',
  'email': '${userData2.read('email')}'
  });
  request.files.add(await http.MultipartFile.fromPath('image',  img));



  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  final result = jsonDecode(response.body) as Map<String, dynamic>;

  if (response.statusCode == 200) {
  //print(await response.stream.bytesToString());
 print(result['image_url']);
 userData2.write('photo', result['image_url']);
  Get.offAll(const DoneScreen());

  print('#################################################################');
  }
  else {
  print(response.reasonPhrase);
  print('#################################################################');

  }
  }
  // Future<void> _pickImage(ImageSource source) async {
  //   try {
  //     final pickedFile = await _imagePicker.pickImage(source: source);
  //     if (pickedFile != null) {
  //       setState(() {
  //         _imageFile = pickedFile;
  //       });
  //     }
  //   } catch (e) {
  //     print('Error picking image: $e');
  //   }
  // }
  static File? file;
  String? imag;
  ImagePicker image = ImagePicker();
  getGallery() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      print(img.path);

      imag = img.path;
      //userData2.write('path', file);
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final HomeController controller = Get.put(HomeController());
  Future<bool> _onWillPop() async {
    if (_formKey.currentState!.validate()) {
      return true; // Allow user to leave if the form is valid.
    } else {
      // Show a confirmation dialog.
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('هل أنت متأكد?'),
          content: const Text('سيتم تجاهل التغييرات الخاصة بك.'),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(true), // Discard changes.
              child: const Text('مسح'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(false), // Stay on the page.
              child: const Text('البقاء'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = UserPreferences.getUserName();
    controller.userBirthDate.value = UserPreferences.getBirthdate();
  }

  @override
  Widget build(BuildContext context) {
    /*  controller.userName.value = AuthController.userName;
    controller.userBirthDate.value = AuthController.userBirthdate; */

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: 'الملف الشخصي',
          onPressed: () {
            Get.to(() => Menu());
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: (){
                    getGallery();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    minRadius: 60.0,
                    child: file != null
                        ?  CircleAvatar(
                      backgroundImage: FileImage(file!),
                      radius: 45,
                    )
                        : Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(
                                  50), // Adding border radius
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 35),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: "الاسم"
                          .text
                          .maxLines(2)
                          .fontWeight(FontWeight.w700)
                          .make(),
                    ),
                  ],
                ),
                10.heightBox,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppbarColor),
                  ),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: UserPreferences.getUserName(),
                      border: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء إدخال الأسم';
                      }
                      return null;
                    },
                    enabled: true,
                  ),
                ),
                const SizedBox(height: 35),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: "تاريخ الميلاد"
                          .text
                          .maxLines(2)
                          .fontWeight(FontWeight.w700)
                          .make(),
                    ),
                  ],
                ),
                10.heightBox,
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppbarColor),
                    ),
                    child: InkWell(
                      onTap: () async {
                        showSelectDateDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Text(
                                    controller.userBirthDate.value,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                const SizedBox(height: 80),
                SizedBox(
                    width: 130,
                    height: 48,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      onPressed: ()   {
                      // await UserPreferences.setUserName(nameController.text);
                       EditImg(imag!);

                        /*  await UserPreferences.setBirthdate(
                              controller.userBirthDate.value); */
                      //  controller.userName.value = nameController.text;
                    //    Get.to(Menu());
                      },
                      child: const Text('حفظ'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future showSelectDateDialog(BuildContext context) async {
    TextEditingController yearController = TextEditingController();
    TextEditingController monthController = TextEditingController();
    TextEditingController dayController = TextEditingController();

    var formattedDate = await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.all(8),
              child: SelectDateWidget(
                yearController,
                monthController,
                dayController,
              ),
            ),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 30)),
                  child: Text("حفظ".tr),
                  onPressed: () async {
                    if (dayController.value.text.isEmpty ||
                        int.parse(dayController.value.text) > 31 ||
                        monthController.value.text.isEmpty ||
                        int.parse(monthController.value.text) > 12 ||
                        yearController.value.text.isEmpty ||
                        int.parse(yearController.value.text) < 1900) {}
                    var userBirthdate =
                        '${yearController.value.text}-${monthController.value.text.length < 2 ? "0" : ""}${monthController.value.text}-${dayController.value.text.length < 2 ? "0" : ""}${dayController.value.text}';
                    controller.userBirthDate.value = userBirthdate;
                    UserPreferences.setBirthdate(userBirthdate);
                    Navigator.pop(context, userBirthdate);
                  },
                ),
              ),
            ],
          );
        });

    if (formattedDate == null) return;
    print(
        formattedDate); //formatted date output using intl package =>  2021-03-16
    controller.changeBirthDateController.text = formattedDate;
    AuthController.userBirthdate = formattedDate;
    UserPreferences.setBirthdate(formattedDate);
    controller.userBirthDate.value = formattedDate;
    controller.calculateBirthDay();
  }
}
