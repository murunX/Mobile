class Game {
  static int gameScore = 0;
  static List<String> choices = ["Rock", "Paper", "Scisors"];
}

class GameChoice {
  String? type = "";
  static var gameRules = {
    "Rock": {
      "Rock": "Тэнцлээ",
      "Paper": "Та хожигдлоо",
      "Scisors": "Та хожлоо",
    },
    "Paper": {
      "Rock": "Та хожлоо",
      "Paper": "Тэнцлээ",
      "Scisors": "Та хожигдлоо",
    },
    "Scisors": {
      "Rock": "Та хожигдлоо",
      "Paper": "Та хожлоо",
      "Scisors": "Тэнцлээ",
    }
  };
  GameChoice(this.type);
}
