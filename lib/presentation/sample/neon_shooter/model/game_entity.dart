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

enum EnemyType { normal, fast, shooter, boss, sine, tracker }

class Enemy extends GameEntity {
  double hp;
  double maxHp;
  EnemyType enemyType;
  int scoreValue;
  double initialX;

  Enemy({
    required super.position,
    required super.size,
    required super.velocity,
    required super.color,
    required this.hp,
    required this.maxHp,
    required this.enemyType,
    required this.scoreValue,
    double? initialX,
  })  : initialX = initialX ?? position.dx,
        super(type: EntityType.enemy);
}

enum WeaponType { single, doubleGun, shotgun, piercing, tracking }

class Player extends GameEntity {
  double hp;
  double maxHp;
  int score;
  WeaponType weaponType;
  double shieldTime; // Remaining time for shield

  Player({
    required super.position,
    required super.size,
    required super.velocity,
    required super.color,
    this.hp = 100,
    this.maxHp = 100,
    this.score = 0,
    this.weaponType = WeaponType.single,
    this.shieldTime = 0,
  }) : super(type: EntityType.player);

  bool get hasShield => shieldTime > 0;
}

class Bullet extends GameEntity {
  double damage;
  bool isPlayerBullet;
  bool isPiercing;
  bool isTracking;

  Bullet({
    required super.position,
    required super.size,
    required super.velocity,
    required super.color,
    required this.damage,
    required this.isPlayerBullet,
    this.isPiercing = false,
    this.isTracking = false,
  }) : super(type: EntityType.bullet);
}

enum ItemType { weapon, shield, heal }

class Item extends GameEntity {
  ItemType itemType;
  WeaponType? weaponType;

  Item({
    required super.position,
    required super.size,
    required super.velocity,
    required super.color,
    required this.itemType,
    this.weaponType,
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
  }) : super(type: EntityType.particle);
}
