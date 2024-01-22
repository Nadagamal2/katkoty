import 'package:flutter/material.dart';

import '../signUp.dart';

class HeaderContainer extends StatelessWidget {
  final String text;

  const HeaderContainer(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appColors, orangeLightColors],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(100),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            right: 20,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
