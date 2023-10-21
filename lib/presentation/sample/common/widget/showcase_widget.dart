import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class ShowcaseWidget extends StatelessWidget {
  const ShowcaseWidget({
    super.key,
    required this.title,
    required this.content,
    required this.builder,
  });

  final String title;
  final String content;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.ss()),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.ss(),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.ss()),
          Text(
            content,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30.ss()),
          builder(context),
        ],
      ),
    );
  }
}
