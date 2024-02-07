import 'dart:typed_data';

import 'package:dart_bitcoin/base58.dart';
import 'package:dart_bitcoin/ecc/rfc_6979.dart';
import 'package:dart_bitcoin/ecc/s_256_point.dart';
import 'package:dart_bitcoin/ecc/signature.dart';
import 'package:dart_bitcoin/helpers/bigint_util.dart';

class PrivateKey {
  late S256Point point;
  BigInt secret;

  PrivateKey(this.secret) {
    point = S256Point.G.smult(secret);
  }

  Signature sign(BigInt z) {
    BigInt k = genK(z);
    BigInt r = S256Point.G.smult(k).x!.num;
    BigInt kinv = k.modPow(S256Point.n - BigInt.two, S256Point.n);
    BigInt temp = (z + r * secret) * kinv;
    BigInt s = temp % S256Point.n;

    BigInt half = S256Point.n ~/ BigInt.two;
    if (s > half) {
      s = S256Point.n - s;
    }

    return Signature(r, s);
  }

  BigInt genK(BigInt z) {
    var rfc = RFC6979KCalculator(S256Point.n, secret, writeBigInt(z));
    return rfc.nextK();
  }

  String wif(bool compressed, bool testnet) {
    Uint8List prefix = Uint8List.fromList(testnet ? [0xef] : [0x80]);
    Uint8List optionalSuffix = Uint8List.fromList(compressed ? [0x01] : []);
    Uint8List combined = Uint8List.fromList(prefix + bigToBuf(secret, 32) + optionalSuffix);
    return encodeBase58Checksum(combined);
  }
}

Uint8List bigToBuf(BigInt num, [int? len]) {
  String str = num.toRadixString(16);
  if (len != null) {
    str = str.padLeft(len * 2, '0');
  } else if (str.length % 2 == 1) {
    str = '0' + str;
  }

  // Convert the hexadecimal string to a list of bytes
  return Uint8List.fromList(List.generate(str.length ~/ 2, (i) {
    return int.parse(str.substring(i * 2, i * 2 + 2), radix: 16);
  }));
}
