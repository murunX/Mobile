import 'package:flutter/material.dart';
import 'package:BieDaalt/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  List<String> _displayElement = ['Rock', 'Paper', 'Scissor'];
  Player _player1 = Player(
    nickname: '',
    socketID: '',
    points: 0,
    playerChoice: '',
  );

  Player _player2 = Player(
    nickname: '',
    socketID: '',
    points: 0,
    playerChoice: '',
  );

  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElements => _displayElement;
  Player get player1 => _player1;
  Player get player2 => _player2;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(String choice) {
    _displayElement = choice as List<String>;
    notifyListeners();
  }

  void clearPlayerChoices() {
    _player1.playerChoice = null;
    _player2.playerChoice = null;
    notifyListeners();
  }

  void updatePlayerChoices(String player1Choice, String player2Choice) {
    print('Updating player choices:');
    print('Player 1 choice before update: ${_player1.playerChoice}');
    print('Player 2 choice before update: ${_player2.playerChoice}');

    _player1.playerChoice = player1Choice;
    _player2.playerChoice = player2Choice;

    print('Player 1 choice after update: ${_player1.playerChoice}');
    print('Player 2 choice after update: ${_player2.playerChoice}');

    notifyListeners();
  }
}
