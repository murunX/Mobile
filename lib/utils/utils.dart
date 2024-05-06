import 'package:flutter/material.dart';
import 'package:mp_tictactoe/screens/main_menu_screen.dart';

void navigateToMainScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MainMenuScreen()),
  );
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Дахин тоглох',
              ),
            ),
            TextButton(
              onPressed: () {
                navigateToMainScreen(context);
              },
              child: const Text(
                'Буцах',
              ),
            ),
          ],
        );
      });
}
