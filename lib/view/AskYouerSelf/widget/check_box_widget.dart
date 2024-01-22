import 'package:flutter/material.dart';

class CheckboxRow extends StatefulWidget {
  final String? option1Text;
  final String? option2Text;
  final bool showText;
  final Function(bool option1, bool option2)? onChanged;

  const CheckboxRow({
    Key? key,
    this.option1Text,
    this.option2Text,
    this.showText = true,
    this.onChanged,
    // required Function(dynamic isChecked) onOption1Selected,
  }) : super(key: key);

  @override
  State<CheckboxRow> createState() => _CheckboxRowState();
}

class _CheckboxRowState extends State<CheckboxRow> {
  bool option1 = false;
  bool option2 = false;

  @override
  Widget build(BuildContext context) {
    final text1 = widget.showText ? (widget.option1Text ?? 'Option 1') : '';
    final text2 = widget.showText ? (widget.option2Text ?? 'Option 2') : '';

    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text1),
            CheckboxTheme(
              data: CheckboxThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(4), // Adjust the radius as needed
                ),
              ),
              child: Checkbox(
                value: option1,
                onChanged: (val) {
                  setState(() {
                    option1 = val ?? false;
                    if (option1) {
                      option2 = false;
                    }
                    if (widget.onChanged != null) {
                      widget.onChanged!(option1, option2);
                    }
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(width: 40),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text2),
            CheckboxTheme(
              data: CheckboxThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(4), // Adjust the radius as needed
                ),
              ),
              child: Checkbox(
                value: option2,
                onChanged: (val) {
                  setState(() {
                    option2 = val ?? false;
                    if (option2) {
                      option1 = false;
                    }
                    if (widget.onChanged != null) {
                      widget.onChanged!(option1, option2);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
