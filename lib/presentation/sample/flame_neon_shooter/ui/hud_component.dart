import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../game/neon_shooter_game.dart';

class HUDComponent extends Component {
  final NeonShooterGame game;
  int _score = 0;
  double _hp = 100;
  double _maxHp = 100;
  int _wave = 1;

  HUDComponent(this.game);

  void updateGameState(int score, double hp, double maxHp, int wave) {
    _score = score;
    _hp = hp;
    _maxHp = maxHp;
    _wave = wave;
  }

  @override
  void render(Canvas canvas) {
    final size = game.size;
    if (size.x == 0 || size.y == 0) return;

    // 顶部边距，让 HUD 不要太靠近屏幕顶部
    const topMargin = 20.0;
    const hudHeight = 80.0;

    // 使用 canvas.translate 平移画布，这样后续所有绘制都会自动应用偏移
    canvas.save();
    canvas.translate(0, topMargin);

    // 绘制 HUD 背景（可选，半透明黑色条）
    final bgPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, hudHeight),
      bgPaint,
    );

    // 绘制分数
    final scoreText = TextPainter(
      text: TextSpan(
        text: 'SCORE: $_score',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(color: Colors.cyan, blurRadius: 10),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    scoreText.layout();
    scoreText.paint(canvas, const Offset(16, 16));

    // 绘制 HP 标签
    final hpLabelText = TextPainter(
      text: const TextSpan(
        text: 'HP: ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    hpLabelText.layout();
    hpLabelText.paint(canvas, const Offset(16, 44));

    // 绘制 HP 条
    const hpBarWidth = 100.0;
    const hpBarHeight = 8.0;
    final hpBarX = 16.0 + hpLabelText.width + 8.0;
    const hpBarY = 44.0;

    // HP 条背景
    final hpBarBgPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(hpBarX, hpBarY, hpBarWidth, hpBarHeight),
      hpBarBgPaint,
    );

    // HP 条前景
    final hpPercent = (_hp / _maxHp).clamp(0.0, 1.0);
    final hpBarForegroundPaint = Paint()
      ..color = _hp > 30 ? Colors.green : Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(hpBarX, hpBarY, hpBarWidth * hpPercent, hpBarHeight),
      hpBarForegroundPaint,
    );

    // 绘制波次
    final waveText = TextPainter(
      text: TextSpan(
        text: 'WAVE: $_wave',
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    waveText.layout();
    waveText.paint(canvas, const Offset(16, hpBarY + hpBarHeight + 8));

    // 恢复画布状态
    canvas.restore();
  }
}
