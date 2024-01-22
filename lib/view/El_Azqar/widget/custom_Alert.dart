import 'package:flutter/material.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_utton.dart';
import '../../../utils/color.dart';

class CustomAlertDialog extends StatefulWidget {
  final Function(String) onSave;

  const CustomAlertDialog({required this.onSave, Key? key}) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: SizedBox(
        width: 355,
        height: 210,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ), */

                    Center(
                      child: Text(
                        'إضافة ذكر',
                        style: TextStyle(fontSize: 22, ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: 'اكتب الذكر هنا...',
                    errorText: _errorMessage,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'قم بكتابة الذكر لإضافته';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextButton(
                        width: 109,
                        height: 35,
                        color: Colors.white,
                        borderRadius: 21,
                        text: 'حفظ ',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String text = _textEditingController.text;
                            widget.onSave(text);
                          }
                        },
                        testSize: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
