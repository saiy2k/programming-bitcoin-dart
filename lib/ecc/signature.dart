import 'dart:typed_data';

import 'package:dart_bitcoin/ecc/s_256_point.dart';

class Signature {
  BigInt r;
  BigInt s;

  Signature(this.r, this.s);

  @override
  String toString() {
    return 'Signature(r: $r, s: $s)';
  }

  /// 1. Start with the 0x30 byte.
  /// 2. Encode the length of the rest of the signature (usually 0x44 or 0x45) and append.
  /// 3. Append the marker byte, 0x02.
  /// 4. Encode r as a big-endian integer, but prepend it with the 0x00 byte if r’s first byte
  /// ≥ 0x80. Prepend the resulting length to r. Add this to the result.
  /// 5. Append the marker byte, 0x02.
  /// 6. Encode s as a big-endian integer, but prepend with the 0x00 byte if s’s first byte ≥
  /// 0x80. Prepend the resulting length to s. Add this to the result.
  /// Thanks to: https://github.com/bmancini55/programming-bitcoin/blob/fa695a2ba962933ef1e593036d5eba1e60059394/src/ecc/Signature.ts#L85
  Uint8List der() {
    Uint8List rBa = writeBigInt(r);
    Uint8List sBa = writeBigInt(s);

    Uint8List rBaEncoded = encodePart(rBa);
    Uint8List sBaEncoded = encodePart(sBa);

    int len = rBaEncoded.length + sBaEncoded.length;
    Uint8List result = Uint8List.fromList(
        [0x30, len + 4, 0x02, rBaEncoded.length, ...rBaEncoded, 0x02, sBaEncoded.length, ...sBaEncoded]);

    return result;
  }
}

Uint8List lstrip(Uint8List bytes, int stripByte) {
  int i = 0;
  while (i < bytes.length && bytes[i] == stripByte) {
    i++;
  }
  return Uint8List.sublistView(bytes, i);
}

Uint8List encodePart(Uint8List v) {
  Uint8List bytes = lstrip(v, 0x00);

  if ((bytes[0] & 0x80) != 0) {
    final prependZero = Uint8List.fromList([0x00]);
    bytes = Uint8List.fromList(prependZero + bytes);
  }

  return bytes;
}
