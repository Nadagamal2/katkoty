import 'package:flutter/material.dart';
import 'package:katkoty/db/model/sibha_Model.dart';

import '../../../utils/color.dart';

class CardWidget extends StatelessWidget {
  final SibhaItemModel dataSibha;
  final void Function()? onClear;

  const CardWidget({
    Key? key,
    required this.dataSibha,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                /*    ListTile(
                    /* title: Center(
                    child: Text(
                      dataSibha.body,
                      style: const TextStyle(
                        color: titleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ), */
                    /* trailing: IconButton(
                    onPressed: onClear,
                    icon: const Icon(
                      Icons.clear_outlined,
                      color: buttons,
                    ),
                  ), */
                    ), */
               const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    dataSibha.body,
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
                      'عدد تكرار الذكر: ${dataSibha.count}',
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
      ),
    );
  }
}
