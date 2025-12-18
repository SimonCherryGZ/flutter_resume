import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HUDComponent extends Component {
  int _score = 0;
  double _hp = 100;
  double _maxHp = 100;
  int _wave = 1;
  bool _gameOver = false;

  void updateGameState(int score, double hp, double maxHp, int wave, bool gameOver) {
    _score = score;
    _hp = hp;
    _maxHp = maxHp;
    _wave = wave;
    _gameOver = gameOver;
  }

  @override
  void render(Canvas canvas) {
    // This will be overlaid by Flutter widgets, so we don't render here
    // The actual HUD will be in the page widget
  }
}
