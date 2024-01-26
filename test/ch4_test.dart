import 'package:dart_bitcoin/s_256_field.dart';
import 'package:dart_bitcoin/s_256_point.dart';
import 'package:test/test.dart';

void main() {
  group('Ch4: Elliptic curve cryptography (ECC)', () {
    test('SEC DER', () {
      S256Point G = S256Point.G;

      print(G.secAsString(false));
      print(G.secAsString(true));

      // z:  96692ddd5c85a0fcd03508697c521b1b00fb17bca080e3733eff7f01f75e281
      // sig:  4d1d9933d637a8ed6fe761b2702e12b09523269687117d607d60dd818f0b6021

      // z:  9dfb9e91acca3ab47bd0d5d6730af84ac10cf00b92e779dbf2fd07a30b112f0
      // sig:  4ea9b7867d6f945261f9f9e82129aab377ece78b8fd32417f6cf08d690dfd39d
    });
  });
}
