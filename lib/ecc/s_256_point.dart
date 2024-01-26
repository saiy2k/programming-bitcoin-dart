import 'dart:typed_data';

import 'package:dart_bitcoin/ecc/field_element.dart';
import 'package:dart_bitcoin/ecc/point.dart';
import 'package:dart_bitcoin/ecc/s_256_field.dart';

class S256Point extends Point<S256Field> {
  static final aa = S256Field(BigInt.zero);
  static final bb = S256Field(BigInt.from(7));

  static final n = BigInt.parse('fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141', radix: 16);

  static final G = S256Point(
      BigInt.parse('79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798', radix: 16),
      BigInt.parse('483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8', radix: 16));

  static final infinity = S256Point(null, null);

  S256Point(BigInt? x, BigInt? y) : super(x != null ? S256Field(x) : null, y != null ? S256Field(y) : null, aa, bb);

  S256Point smult(BigInt scalar) {
    BigInt sc = scalar % S256Point.n;

    Point point = super.smult(sc);

    return S256Point(point.x != null ? point.x!.num : null, point.y != null ? point.y!.num : null);
  }

  Uint8List sec(bool compressed) {
    if (compressed) {
      return Uint8List.fromList([y!.num.isEven ? 0x02 : 0x03] + writeBigInt(x!.num));
    } else {
      return Uint8List.fromList([0x04] + writeBigInt(x!.num) + writeBigInt(y!.num));
    }
  }

  String secAsString(bool compressed) {
    return uint8ListToHex(sec(compressed));
  }
}

String uint8ListToHex(Uint8List data) {
  return data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}

// https://github.com/dart-lang/sdk/issues/32803#issuecomment-1228291047
BigInt readBytes(Uint8List bytes) {
  BigInt result = BigInt.zero;

  for (final byte in bytes) {
    // reading in big-endian, so we essentially concat the new byte to the end
    result = (result << 8) | BigInt.from(byte & 0xff);
  }
  return result;
}

Uint8List writeBigInt(BigInt number) {
  // Not handling negative numbers. Decide how you want to do that.
  int bytes = (number.bitLength + 7) >> 3;
  var b256 = BigInt.from(256);
  var result = Uint8List(bytes);
  for (int i = 0; i < bytes; i++) {
    result[bytes - 1 - i] = number.remainder(b256).toInt();
    number = number >> 8;
  }
  return result;
}
