import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/sample.dart';
import 'package:flutter_resume/utils/utils.dart';

class SampleShaderScreen extends StatelessWidget {
  const SampleShaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shader')),
      body: _SampleShaderScreenContent(),
    );
  }
}

class _SampleShaderScreenContent extends StatefulWidget {
  @override
  State<_SampleShaderScreenContent> createState() =>
      _SampleShaderScreenContentState();
}

class _SampleShaderScreenContentState
    extends State<_SampleShaderScreenContent> {
  BoxFit _fit = BoxFit.contain;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _ImageItemWidget(
            assetImagePath: 'assets/images/sample_photo_1.jpg',
            fit: _fit,
          ),
        ),
        Expanded(
          child: _ImageItemWidget(
            assetImagePath: 'assets/images/sample_photo_2.jpg',
            fit: _fit,
          ),
        ),
        Expanded(
          child: _ImageItemWidget(
            assetImagePath: 'assets/images/sample_photo_3.jpg',
            fit: _fit,
          ),
        ),
        SizedBox(height: 20.ss()),
        _BoxFitRadioGroupWidget(
          fit: _fit,
          onChanged: (fit) {
            if (fit != null) {
              setState(() {
                _fit = fit;
              });
            }
          },
        ),
        SizedBox(height: 20.ss()),
      ],
    );
  }
}

class _ImageItemWidget extends StatefulWidget {
  const _ImageItemWidget({required this.assetImagePath, required this.fit});

  final String assetImagePath;
  final BoxFit fit;

  @override
  State<_ImageItemWidget> createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<_ImageItemWidget> {
  PixelationFilter? _filter;
  late BoxFit _fit;

  @override
  void initState() {
    super.initState();
    _fit = widget.fit;
  }

  @override
  void didUpdateWidget(covariant _ImageItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _fit = widget.fit;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (_filter == null) {
          return;
        }
        final dy = details.delta.dy;
        var pixels = _filter!.pixels;
        pixels -= dy;
        pixels = pixels.clamp(10, 100);
        setState(() {
          _filter!.updatePixels(pixels);
        });
      },
      child: AssetImageShaderWidget(
        assetImagePath: widget.assetImagePath,
        fit: _fit,
        filterBuilder: (image) {
          _filter ??= PixelationFilter(image: image, pixels: 50);
          return _filter!;
        },
      ),
    );
  }
}

class _BoxFitRadioGroupWidget extends StatelessWidget {
  const _BoxFitRadioGroupWidget({required this.fit, required this.onChanged});

  final BoxFit fit;
  final void Function(BoxFit? fit) onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<BoxFit>(
      groupValue: fit,
      onChanged: onChanged,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BoxFitRadioWidget(fit: BoxFit.contain),
          _BoxFitRadioWidget(fit: BoxFit.cover),
          _BoxFitRadioWidget(fit: BoxFit.fill),
        ],
      ),
    );
  }
}

class _BoxFitRadioWidget extends StatelessWidget {
  const _BoxFitRadioWidget({required this.fit});

  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(fit.name, style: const TextStyle(color: Colors.black)),
        Radio<BoxFit>(value: fit),
      ],
    );
  }
}
