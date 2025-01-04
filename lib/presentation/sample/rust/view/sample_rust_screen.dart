import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_resume/src/rust/api/des.dart';
import 'package:oktoast/oktoast.dart';

class SampleRustScreen extends StatelessWidget {
  const SampleRustScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rust'),
      ),
      body: _SampleRustScreenContent(),
    );
  }
}

class _SampleRustScreenContent extends StatefulWidget {
  @override
  State<_SampleRustScreenContent> createState() =>
      _SampleRustScreenContentState();
}

class _SampleRustScreenContentState extends State<_SampleRustScreenContent> {
  late final TextEditingController _keyEditController;
  late final TextEditingController _plaintextEditController;
  late final TextEditingController _encryptedBase64EditController;
  late final FocusNode _keyFocusNode;
  late final FocusNode _plaintextFocusNode;
  late final FocusNode _encryptedBase64FocusNode;

  @override
  void initState() {
    super.initState();
    _keyEditController = TextEditingController();
    _plaintextEditController = TextEditingController();
    _encryptedBase64EditController = TextEditingController();
    _keyFocusNode = FocusNode();
    _plaintextFocusNode = FocusNode();
    _encryptedBase64FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _keyEditController.dispose();
    _plaintextEditController.dispose();
    _encryptedBase64EditController.dispose();
    _keyFocusNode.dispose();
    _plaintextFocusNode.dispose();
    _encryptedBase64FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              '🐦 <=> 🦀\n演示用 Rust 实现 DES 加解密',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '密钥（长度必须为 8 字节）',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                    TextField(
                      controller: _keyEditController,
                      focusNode: _keyFocusNode,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '待加密文本',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                    TextField(
                      controller: _plaintextEditController,
                      focusNode: _plaintextFocusNode,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _onTapEncrypt();
                      },
                      child: const Text('DES 加密'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '待解密 Base64 编码文本',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                    TextField(
                      controller: _encryptedBase64EditController,
                      focusNode: _encryptedBase64FocusNode,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _onTaDecrypt();
                      },
                      child: const Text('DES 解密'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _keyAvailable(String key) {
    if (key.isEmpty) {
      showToast('密钥不能为空');
      return false;
    }
    if (key.length != 8) {
      showToast('密钥长度必须为 8 位');
      return false;
    }
    return true;
  }

  void _hideKeyboard() {
    _keyFocusNode.unfocus();
    _plaintextFocusNode.unfocus();
    _encryptedBase64FocusNode.unfocus();
  }

  void _onTapEncrypt() {
    _hideKeyboard();
    final key = _keyEditController.text;
    if (!_keyAvailable(key)) {
      return;
    }
    final plaintext = _plaintextEditController.text;
    _desEncrypt(plaintext: plaintext, key: key).then((encryptedBase64) {
      if (!mounted || encryptedBase64 == null) {
        return;
      }
      _encryptedBase64EditController.text = encryptedBase64;
    });
  }

  void _onTaDecrypt() {
    _hideKeyboard();
    final key = _keyEditController.text;
    if (!_keyAvailable(key)) {
      return;
    }
    final encryptedBase64 = _encryptedBase64EditController.text;
    _desDecrypt(encryptedBase64: encryptedBase64, key: key).then((plaintext) {
      if (!mounted || plaintext == null) {
        return;
      }
      _plaintextEditController.text = plaintext;
    });
  }

  Future<String?> _desEncrypt({
    required String plaintext,
    required String key,
  }) async {
    try {
      return desEncrypt(
        data: utf8.encode(plaintext),
        key: utf8.encode(key),
      );
    } catch (e, _) {
      showToast(e.toString());
    }
    return null;
  }

  Future<String?> _desDecrypt({
    required String encryptedBase64,
    required String key,
  }) async {
    try {
      final bytes = await desDecrypt(
        encryptedBase64: encryptedBase64,
        key: utf8.encode(key),
      );
      return String.fromCharCodes(bytes);
    } catch (e, _) {
      showToast(e.toString());
    }
    return null;
  }
}
