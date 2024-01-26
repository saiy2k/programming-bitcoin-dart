import 'dart:typed_data';

import 'package:dart_bitcoin/ecc/rfc_6979.dart';
import 'package:dart_bitcoin/ecc/s_256_point.dart';
import 'package:dart_bitcoin/ecc/signature.dart';
import 'package:pointycastle/pointycastle.dart' hide PrivateKey, Signature;
import 'package:test/test.dart';

import 'package:dart_bitcoin/ecc/private_key.dart';

void main() {
  group('Ch4: Elliptic curve cryptography (ECC)', () {
    test('SEC DER', () {
      S256Point G = S256Point.G;

      // print(G.secAsString(false));
      // print(G.secAsString(true));
    });
  });
}
