import 'package:flutter/material.dart';

class DifficultySelectionRow extends StatefulWidget {
  const DifficultySelectionRow({super.key});

  @override
  State<DifficultySelectionRow> createState() => _DifficultySelectionRowState();
}

class _DifficultySelectionRowState extends State<DifficultySelectionRow> {
  String? selectedDifficulty;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDifficulty = 'سهل';
            });
          },
          child: Row(
            children: [
              Radio(
                value: 'سهل',
                groupValue: selectedDifficulty,
                onChanged: (value) {
                  setState(() {
                    selectedDifficulty = value.toString();
                  });
                },
              ),
              const Text(
                'سهل',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDifficulty = 'صعب';
            });
          },
          child: Row(
            children: [
              Radio(
                value: 'صعب',
                groupValue: selectedDifficulty,
                onChanged: (value) {
                  setState(() {
                    selectedDifficulty = value.toString();
                  });
                },
              ),
              const Text(
                'صعب',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
