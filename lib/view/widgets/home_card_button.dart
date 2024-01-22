import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton(
      {Key? key,
      required this.image,
      required this.text,
      this.onPressed,
      this.scale = 1})
      : super(key: key);

  final String image;
  final String text;
  final double? scale;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.3,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 5,
              ),
              Image.asset(
                image,
                width: 77,
                height: 77,
                fit: BoxFit.contain,
              ),
              FittedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                  child: Container(
                    alignment: Alignment.center,
                    width: 110,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xfff6c116),
                    ),
                    child: FittedBox(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        text,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, /*  fontSize: 16 */
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
