import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dart_bitcoin/base58.dart';
import 'package:dart_bitcoin/ecc/field_element.dart';
import 'package:dart_bitcoin/ecc/operable.dart';
import 'package:dart_bitcoin/ecc/point.dart';
import 'package:dart_bitcoin/ecc/s_256_field.dart';
import 'package:dart_bitcoin/ecc/signature.dart';
import 'package:dart_bitcoin/helpers/bigint_util.dart';
import 'package:dart_bitcoin/helpers/crypto.dart';
import 'package:dart_bitcoin/helpers/hex.dart';
import 'package:pointycastle/digests/ripemd160.dart';

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

  bool verify(BigInt z, Signature sig) {
    BigInt sInv = sig.s.modPow(S256Point.n - BigInt.two, S256Point.n);
    BigInt u = (z * sInv) % S256Point.n;
    BigInt v = (sig.r * sInv) % S256Point.n;

    Point<IOperable> total = S256Point.G.smult(u) + smult(v);

    return total.x!.num == sig.r;
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

  String address(bool compressed, bool testnet) {
    Uint8List prefix = Uint8List.fromList(testnet ? [0x6f] : [0x00]);
    Uint8List bytes = sec(compressed);
    Uint8List preHash = Uint8List.fromList(prefix + hash160(bytes));
    return encodeBase58Checksum(preHash);
  }
}
