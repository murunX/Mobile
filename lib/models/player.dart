class Player {
  final String nickname;
  final String socketID;
  final double points;
  String? playerChoice; // New field for player's choice
  Player({
    required this.nickname,
    required this.socketID,
    required this.points,
    required this.playerChoice,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'points': points,
      'playerChoice': playerChoice,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] ?? '',
      socketID: map['socketID'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      playerChoice:
          map['playerChoice'] ?? '', // Initialize playerChoice from map
    );
  }

  Player copyWith({
    String? nickname,
    String? socketID,
    double? points,
    String? playerChoice,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerChoice: playerChoice ?? this.playerChoice,
    );
  }
}
