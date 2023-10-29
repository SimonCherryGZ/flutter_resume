import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart';

final colourCache = <String, List<List<int>>>{};

class Identicon {
  Identicon({
    int rows = 6,
    int cols = 6,
  })  : _rows = rows,
        _cols = cols;

  static Uint8List getBytes(String text) {
    return IdenticonCache().getIdenticon(text);
  }

  Uint8List generate(
    String text, {
    int size = 36,
  }) {
    const bytesLength = 16;
    final hexDigest = _digest(utf8.encode(text)).toString();

    final hexDigestByteList = List<int>.generate(
      bytesLength,
      (int i) {
        return int.parse(
          hexDigest.substring(i * 2, i * 2 + 2),
          radix: bytesLength,
        );
      },
    );

    _generateColours(hexDigest);

    final matrix = _createMatrix(hexDigestByteList);
    return _createImage(
      matrix,
      size,
      size,
      (size * 0.1).toInt(),
    );
  }

  final int _rows;
  final int _cols;
  final Function(List<int>) _digest = md5.convert;

  List<int>? _fgColour;
  List<int>? _bgColour;

  _generateColours(String cacheKey) {
    var coloursOk = false;

    if (colourCache.containsKey(cacheKey)) {
      _fgColour = colourCache[cacheKey]![0];
      _bgColour = colourCache[cacheKey]![1];
    } else {
      while (!coloursOk) {
        _fgColour = _getPastelColour();
        if (_bgColour == null) {
          _bgColour = _getPastelColour(lighten: 80);

          final fgLum = _luminance(_fgColour) + 0.05;
          final bgLum = _luminance(_bgColour) + 0.05;
          if (fgLum / bgLum > 1.20) {
            coloursOk = true;
          }
        } else {
          coloursOk = true;
        }
      }
      colourCache[cacheKey] = [_fgColour!, _bgColour!];
    }
  }

  List<int> _getPastelColour({int lighten = 127}) {
    r() => Random().nextInt(128) + lighten;
    return [r(), r(), r()];
  }

  double _luminance(rgb) {
    final a = [];
    for (var v in rgb) {
      v = v / 255.0;
      final result =
          (v < 0.03928) ? v / 12.92 : pow(((v + 0.055) / 1.055), 2.4);
      a.add(result);
    }
    return a[0] * 0.2126 + a[1] * 0.7152 + a[2] * 0.0722;
  }

  bool _bitIsOne(int n, List<int> hashBytes) {
    const scale = 16;
    return hashBytes[n ~/ (scale / 2)] >>
                ((scale / 2) - ((n % (scale / 2)) + 1)).toInt() &
            1 ==
        1;
  }

  Uint8List _createImage(
    List<List<bool>> matrix,
    int width,
    int height,
    int pad,
  ) {
    final image = Image(
      width: width + (pad * 2),
      height: height + (pad * 2),
      backgroundColor: ColorRgb8(_bgColour![0], _bgColour![1], _bgColour![2]),
    );

    final blockWidth = width ~/ _cols;
    final blockHeight = height ~/ _rows;

    for (int row = 0; row < matrix.length; row++) {
      for (int col = 0; col < matrix[row].length; col++) {
        if (matrix[row][col]) {
          fillRect(
            image,
            x1: pad + col * blockWidth,
            y1: pad + row * blockHeight,
            x2: pad + (col + 1) * blockWidth - 1,
            y2: pad + (row + 1) * blockHeight - 1,
            color: ColorRgb8(_fgColour![0], _fgColour![1], _fgColour![2]),
          );
        }
      }
    }
    return encodePng(image);
  }

  List<List<bool>> _createMatrix(List<int> byteList) {
    final cells = (_rows * _cols / 2 + _cols % 2).toInt();
    final matrix = List.generate(
      _rows,
      (_) => List.generate(
        _cols,
        (_) => false,
      ),
    );

    for (int n = 0; n < cells; n++) {
      if (_bitIsOne(n, byteList.getRange(1, byteList.length).toList())) {
        final row = n % _rows;
        final col = n ~/ _cols;
        matrix[row][_cols - col - 1] = true;
        matrix[row][col] = true;
      }
    }
    return matrix;
  }
}

class IdenticonCache {
  factory IdenticonCache() {
    _instance ??= IdenticonCache._();
    return _instance!;
  }

  IdenticonCache._() : _cache = <String, Uint8List>{};

  static IdenticonCache? _instance;

  final Map<String, Uint8List> _cache;

  Uint8List getIdenticon(String key) {
    var bytes = _cache[key];
    if (bytes == null) {
      bytes = Identicon().generate(key);
      _cache[key] = bytes;
    }
    return bytes;
  }
}
