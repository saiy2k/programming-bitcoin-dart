import 'dart:typed_data';

import 'package:dart_bitcoin/ecc/rfc_6979.dart';
import 'package:dart_bitcoin/ecc/s_256_point.dart';
import 'package:pointycastle/pointycastle.dart' hide PrivateKey;
import 'package:test/test.dart';

import 'package:dart_bitcoin/ecc/private_key.dart';

void main() {
  group('Ch4: Elliptic curve cryptography (ECC)', () {
    test('SEC DER', () {
      S256Point G = S256Point.G;

      // print(G.secAsString(false));
      // print(G.secAsString(true));
    });

    test('RFC6979', () {
      // r: 5d cd f7 f1 83 a5 81 1f d0 db 5a fc 96 d8 43 e5 ea 6d 1b 26 c9 60 61 2c ca 90 7e eb 7d fd 16 94
      // secret: 42429009809082141725132919433061711592045833497313101863205160517344052450964
      // randMsg: 40 65 ee 77 81 3c 4b 8e a4 b6 7c 55 a1 93 0c c6 4f ba ce f0 e2 f1 be e0 91 c2 75 cf 84 05 9c 31
      // z: 29128119700345944827632412315927596533461928550523143039175478156556300033073
      // rfcHash: 20889311776560637325212081170397242351715008433244209396146804465420672466763
      // sig: 20889311776560637325212081170397242351715008433244209396146804465420672466763

      String prHex = '5dcdf7f183a5811fd0db5afc96d843e5ea6d1b26c960612cca907eeb7dfd1694';
      BigInt d = BigInt.parse(prHex, radix: 16);
      print(d);

      String msg = '4065ee77813c4b8ea4b67c55a1930cc64fbacef0e2f1bee091c275cf84059c31';
      BigInt z = BigInt.parse(msg, radix: 16);
      print(z);

      Uint8List zInt = writeBigInt(z);

      Mac _mac = Mac('SHA-256/HMAC');
      var rfc = RFC6979KCalculator(_mac, S256Point.n, d, zInt);
      print(rfc.nextK());
    });

    test('Sign', () {
      // r: 5d cd f7 f1 83 a5 81 1f d0 db 5a fc 96 d8 43 e5 ea 6d 1b 26 c9 60 61 2c ca 90 7e eb 7d fd 16 94
      // secret: 42429009809082141725132919433061711592045833497313101863205160517344052450964
      // randMsg: 40 65 ee 77 81 3c 4b 8e a4 b6 7c 55 a1 93 0c c6 4f ba ce f0 e2 f1 be e0 91 c2 75 cf 84 05 9c 31
      // z: 29128119700345944827632412315927596533461928550523143039175478156556300033073
      // rfcHash: 20889311776560637325212081170397242351715008433244209396146804465420672466763
      // sig: 20889311776560637325212081170397242351715008433244209396146804465420672466763

      String prHex = '5dcdf7f183a5811fd0db5afc96d843e5ea6d1b26c960612cca907eeb7dfd1694';
      BigInt d = BigInt.parse(prHex, radix: 16);
      print(d);

      String msg = '4065ee77813c4b8ea4b67c55a1930cc64fbacef0e2f1bee091c275cf84059c31';
      BigInt z = BigInt.parse(msg, radix: 16);
      print(z);

      Uint8List zInt = writeBigInt(z);

      PrivateKey pk = PrivateKey(d);

      print('Signature:');
      pk.sign(z);
    });
  });
}
