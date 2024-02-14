import 'package:flutter/material.dart';

enum ColorType {
  red(name: '红色', color: Colors.red),
  pink(name: '粉红', color: Colors.pinkAccent),
  brown(name: '褐色', color: Colors.brown),
  yellow(name: '黄色', color: Colors.yellow),
  green(name: '绿色', color: Colors.green),
  cyan(name: '青色', color: Colors.cyan),
  blue(name: '蓝色', color: Colors.blue),
  purple(name: '紫色', color: Colors.purple);

  final String name;
  final Color color;

  const ColorType({
    required this.name,
    required this.color,
  });
}
