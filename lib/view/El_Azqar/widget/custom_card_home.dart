import 'package:flutter/material.dart';
import 'package:katkoty/db/model/sibha_Model.dart';
import '../../../db/model/changeZqer.dart';
import '../../../utils/color.dart';

class CardWidgetHome extends StatelessWidget {
  final SibhaItemModel? dataSibha;
  final SibhaHomeItemModel? dataSibhaHome;

  const CardWidgetHome({Key? key, this.dataSibha, this.dataSibhaHome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dataSibha != null) {
      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /*  ListTile(
                  title: Center(
                    child: Text(
                      dataSibha!.title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: titleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ), */
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    dataSibha!.body,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'عدد تكرار الذكر: ${dataSibha!.count}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: titleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (dataSibhaHome != null) {
      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Card(
              // ... customize the card UI for SibhaHomeItemModel ...
              ),
        ),
      );
    } else {
      return const Center(
        child: Text('No data available'),
      );
    }
  }
}
