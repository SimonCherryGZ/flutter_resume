import 'dart:ui';

enum EntityType { player, enemy, bullet, item, particle }

class GameEntity {
  Offset position;
  Size size;
  Offset velocity;
  Color color;
  EntityType type;
  bool shouldRemove = false;
  int lastHitTick = 0;

  GameEntity({
    required this.position,
    required this.size,
    required this.velocity,
    required this.color,
    required this.type,
    this.lastHitTick = 0,
  });

  void update() {
    position += velocity;
  }

  Rect get rect => position & size;
}

enum EnemyType { normal, fast, shooter, boss }

class Enemy extends GameEntity {
  double hp;
  double maxHp;
  EnemyType enemyType;
  int scoreValue;

  Enemy({
    required super.position,
    required super.size,
    required super.velocity,
    required super.color,
    required this.hp,
    required this.maxHp,
    required this.enemyType,
    required this.scoreValue,
  }) : super(type: EntityType.enemy);
}

class Player extends GameEntity {
  double hp;
  double maxHp;
  int score;
  int weaponLevel;
  double shieldTime; // Remaining time for shield

  Player({
    required super.position,
    required super.size,
    required super.velocity,
    required super.color,
    this.hp = 100,
    this.maxHp = 100,
    this.score = 0,
    this.weaponLevel = 1,
    this.shieldTime = 0,
  }) : super(type: EntityType.player);

  bool get hasShield => shieldTime > 0;
}

class Bullet extends GameEntity {
  double damage;
  bool isPlayerBullet;

  Bullet({
    required super.position,
    required super.size,
    required super.velocity,
    required super.color,
    required this.damage,
    required this.isPlayerBullet,
  }) : super(type: EntityType.bullet);
}

enum ItemType { weapon, shield, heal }

class Item extends GameEntity {
  ItemType itemType;

  Item({
    required super.position,
    required super.size,
    required super.velocity,
    required super.color,
    required this.itemType,
  }) : super(type: EntityType.item);
}

class Particle extends GameEntity {
  double life; // 0.0 to 1.0
  double decay;

  Particle({
    required super.position,
    required super.size,
    required super.velocity,
    required super.color,
    required this.life,
    required this.decay,
  }) : super(type: EntityType.bullet); // Using bullet type as placeholder or add new type if needed, but for now it's fine. 
  // Actually let's add EntityType.particle to be clean.
}
