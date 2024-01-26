import 'package:dart_bitcoin/ecc/rfc_6979.dart';
import 'package:dart_bitcoin/ecc/s_256_point.dart';
import 'package:dart_bitcoin/ecc/signature.dart';

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
}
