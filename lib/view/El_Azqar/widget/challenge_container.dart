import 'package:flutter/material.dart';

class ChallengeBox extends StatelessWidget {
  const ChallengeBox(
      {super.key,
      this.imagepath,
      this.challengeday,
      required bool isCompleted});
  final String? imagepath;
  final Widget? challengeday;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Center(
              child: Image.asset(
            imagepath!,
          )),
          challengeday!
        ],
      ),
    );
  }
}
