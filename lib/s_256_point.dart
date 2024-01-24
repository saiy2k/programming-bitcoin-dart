import 'package:dart_bitcoin/field_element.dart';
import 'package:dart_bitcoin/point.dart';
import 'package:dart_bitcoin/s_256_field.dart';

class S256Point extends Point<S256Field> {
  late S256Field xx, yy;

  static final aa = S256Field(BigInt.zero);
  static final bb = S256Field(BigInt.from(7));

  static final n = BigInt.parse('fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141', radix: 16);

  static final G = S256Point(
      BigInt.parse('79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798', radix: 16),
      BigInt.parse('483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8', radix: 16));

  // static final infinity = S256Point(null, null);

  S256Point(BigInt x, BigInt y) : super(S256Field(x), S256Field(y), aa, bb);
}
