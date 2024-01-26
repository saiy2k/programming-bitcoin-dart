import 'dart:math';
import 'dart:typed_data';

import 'package:dart_bitcoin/rfc_6979.dart';
import 'package:dart_bitcoin/s_256_point.dart';
import 'package:pointycastle/pointycastle.dart';

class PrivateKey {
  late S256Point point;
  BigInt secret;

  PrivateKey(this.secret) {
    point = S256Point.G.smult(secret);
  }

  sign(BigInt z) {
    BigInt k = genK(z);
    BigInt r = S256Point.G.smult(k).x!.num;
    BigInt kinv = k.modPow(S256Point.n - BigInt.two, S256Point.n);
    BigInt temp = (z + r * secret) * kinv;
    BigInt s = temp % S256Point.n;

    BigInt half = S256Point.n ~/ BigInt.two;
    if (s > half) {
      s = S256Point.n - s;
    }

    print(r);
    print(s);
  }

  BigInt genK(BigInt z) {
    Mac mac = Mac('SHA-256/HMAC');
    var rfc = RFC6979KCalculator(mac, S256Point.n, secret, writeBigInt(z));
    return rfc.nextK();
  }
}
