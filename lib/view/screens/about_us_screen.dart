import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailto/mailto.dart';
import 'package:open_store/open_store.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUSScreen extends StatelessWidget {
  const AboutUSScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عن التطبيق'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "about_msg".tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "contact_developer".tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final mailtoLink = Mailto(
                      to: ['asmaasabra6969@gmail.com'],
                      subject: 'اقتراح لتطبيق كتكوتي',
                    );
                    await launch('$mailtoLink');
                  },
                  child: Text('facebook'.tr),
                ),
                ElevatedButton(
                  onPressed: () {
                    OpenStore.instance.open(
                      appStoreId: '284815942',
                      androidAppBundleId: 'com.katkoty.app',
                    );
                  },
                  child: Text('rate'.tr),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
