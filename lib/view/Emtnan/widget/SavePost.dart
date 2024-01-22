import 'package:flutter/material.dart';

import '../../../utils/color.dart';

class SavePost extends StatelessWidget {
  const SavePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'report',
            child: Row(
              children: [
                Icon(Icons.report, color: AppbarColor),
                SizedBox(width: 8),
                Text('الإبلاغ عن البوست'),
              ],
            ),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 'save') {
        } else if (value == 'report') {}
      },
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
