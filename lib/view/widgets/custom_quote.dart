import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class CustomQuote extends StatelessWidget {
  const CustomQuote({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.amber[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
              child: Text(
                text,
                style: GoogleFonts.caveat(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 30,
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
                      Clipboard.setData(ClipboardData(text: text));
                      Fluttertoast.showToast(msg: 'تم النسخ');
                    },
                    icon: const Icon(Icons.copy)),
                IconButton(
                    onPressed: () {
                      Share.share(text);
                    },
                    icon: const Icon(Icons.share)),
              ],
            )
          ],
        ));
  }
}
