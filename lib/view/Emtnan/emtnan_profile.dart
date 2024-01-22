import 'package:flutter/material.dart';

import 'widget/buildUserlist.dart';
import 'widget/emtnan_profile_items.dart';

class EmtnanProfile extends StatefulWidget {
  const EmtnanProfile({super.key});

  @override
  State<EmtnanProfile> createState() => _EmtnanProfileState();
}

class _EmtnanProfileState extends State<EmtnanProfile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              buildUserlist(),

              const SizedBox(
                width: double.infinity,
                height: 500,
                child: EmtnanProfileItems(),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
