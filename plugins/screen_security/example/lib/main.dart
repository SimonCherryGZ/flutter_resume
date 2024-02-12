import 'package:flutter/material.dart';
import 'package:screen_security/screen_security.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home Page'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('当前页面可截屏、录屏'),
                  const SizedBox(height: 30),
                  const Icon(
                    Icons.home,
                    size: 100,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const _NewScreen(),
                      ));
                    },
                    child: const Text('Jump To Next Page'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NewScreen extends StatefulWidget {
  const _NewScreen();

  @override
  State<_NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<_NewScreen> {
  @override
  void initState() {
    super.initState();
    ScreenSecurity.enable();
  }

  @override
  void dispose() {
    ScreenSecurity.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('当前页面不可截屏、录屏'),
            const SizedBox(height: 30),
            const Icon(
              Icons.home,
              size: 100,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back To Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
