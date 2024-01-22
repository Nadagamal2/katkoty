import 'package:flutter/material.dart';
import 'package:katkoty/view/AskYouerSelf/widget/list_azkar.dart';

import 'elazkar.dart';

class ElazkarScreen extends StatelessWidget {
  const ElazkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ListOfAzkar(),
        ElazkaWidget()
      ],
    );
  }
}
