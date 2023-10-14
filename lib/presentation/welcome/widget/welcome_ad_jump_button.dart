import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class WelcomeAdJumpButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback? clickJumpCallback;

  const WelcomeAdJumpButton({
    super.key,
    required this.buttonText,
    this.clickJumpCallback,
  });

  @override
  State<WelcomeAdJumpButton> createState() => _WelcomeAdJumpButtonState();
}

class _WelcomeAdJumpButtonState extends State<WelcomeAdJumpButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animationController.view,
      child: _InnerJumpButton(
        widget.buttonText,
        widget.clickJumpCallback,
      ),
    );
  }
}

class _InnerJumpButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? clickJumpCallback;

  const _InnerJumpButton(
    this.buttonText,
    this.clickJumpCallback,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        clickJumpCallback?.call();
      },
      child: Container(
        width: 200.ss(),
        height: 50.ss(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.ss()),
          color: Colors.yellow,
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange,
              blurRadius: 6.ss(),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 40.ss()),
              Text(
                buttonText,
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20.ss(),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(width: 20.ss()),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.deepOrange,
                size: 20.ss(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
