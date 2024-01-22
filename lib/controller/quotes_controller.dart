import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/models/ArticlesModelresponse.dart';
import 'package:katkoty/models/resources.dart';
import 'package:katkoty/models/status.dart';
import 'package:katkoty/service/api_service.dart';
import 'package:katkoty/view/widgets/custom_quote.dart';
import 'package:share_plus/share_plus.dart';

class QuotesController extends GetxController {
  static ApiService apiService = Get.find();
  AppDatabase appDatabase = AppDatabase();
  RxList quotesMap = [].obs;

  openQuotes(BuildContext context, quote) {
    return Get.defaultDialog(
        title: 'سلسلة التغيير'.tr,
        textCancel: 'رجوع'.tr,
        confirmTextColor: Colors.black,
        cancelTextColor: Colors.black,
        radius: 20,
        content: SizedBox(
          height: 400,
          width: 1000,
          child: Card(
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Text(
                    quote,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    height: 2,
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: quote));
                            Fluttertoast.showToast(msg: 'تم النسخ');
                          },
                          icon: const Icon(Icons.copy)),
                      IconButton(
                          onPressed: () {
                            Share.share(quote);
                          },
                          icon: const Icon(Icons.share)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  addQuotes() async {
    appDatabase.getAllArticles().then((value) async {
      if (value.isNotEmpty) {
        quotesMap.clear();
        quotesMap.addAll(value);
      }
      Resource<ArticlesModelResponse> response =
          await apiService.getDrAhmedArticles();
      if (response.status == Status.SUCCESS) {
        var quoteList = response.data!.article!;
        quotesMap.clear();
        quotesMap.addAll(quoteList);
        for (var element in quoteList) {
          appDatabase.insert(element);
        }
      }
    });
  }

  getQuote(text) {
    return CustomQuote(text: text);
  }

  doctorAhmedDialog() {
    return Get.defaultDialog(
        title: ' ',
        textCancel: 'استمرار',
        radius: 20,
        content: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                    height: 150,
                    child: Image.asset('assets/images/doctor_ahmed.png')),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                  '* صاحب تلك السلسلة هو الدكتور أحمد سمير بدأها عام 2017'),
              const SizedBox(
                height: 5,
              ),
              const Text('* المتخصص في التعليم الطبي بجامعة المنصورة'),
              const SizedBox(
                height: 5,
              ),
              const Text(
                  '* الحاصل على ماجستير التعليم الطبي من جامعة ماستريخت بهولندا'),
              const SizedBox(
                height: 5,
              ),
              const Text('* وأيضاً ماجستير إدارة الأعمال من MBA'),
              const SizedBox(
                height: 5,
              ),
              const Text(
                  '* ويملك شغفاً كبيراً في مساعدة الطلبة والخريجين على التخطيط لأهدافهم وتطوير شخصياتهم'),
            ],
          ),
        ));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addQuotes();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    doctorAhmedDialog();
  }
}
