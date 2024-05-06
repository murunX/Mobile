import 'package:flutter/material.dart';
import 'package:mp_tictactoe/resources/socket_methods.dart';
import 'package:mp_tictactoe/screens/main_menu_screen.dart';

final SocketMethods _socketMethods = SocketMethods();
final TextEditingController _gameIdController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
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
              _socketMethods.exitRoom(
                _nameController.text,
                _gameIdController.text,
              );
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Буцах'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Үргэлжлүүлэх'),
          ),
        ],
      );
    },
  );
}
