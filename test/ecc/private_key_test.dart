import 'dart:typed_data';

import 'package:dart_bitcoin/ecc/rfc_6979.dart';
import 'package:dart_bitcoin/ecc/s_256_point.dart';
import 'package:dart_bitcoin/ecc/signature.dart';
import 'package:dart_bitcoin/helpers/bigint_util.dart';
import 'package:pointycastle/pointycastle.dart' hide PrivateKey, Signature;
import 'package:test/test.dart';

import 'package:dart_bitcoin/ecc/private_key.dart';

void main() {
  group('Private key', () {
    test('RFC6979', () {
      String prHex = '5dcdf7f183a5811fd0db5afc96d843e5ea6d1b26c960612cca907eeb7dfd1694';
      String prDec = '42429009809082141725132919433061711592045833497313101863205160517344052450964';
      BigInt d = BigInt.parse(prHex, radix: 16);
      expect(d, equals(BigInt.parse(prDec, radix: 10)));

      String msgHex = '4065ee77813c4b8ea4b67c55a1930cc64fbacef0e2f1bee091c275cf84059c31';
      String msgDec = '29128119700345944827632412315927596533461928550523143039175478156556300033073';
      BigInt z = BigInt.parse(msgHex, radix: 16);
      expect(z, equals(BigInt.parse(msgDec, radix: 10)));

      Uint8List zInt = writeBigInt(z);

      RFC6979KCalculator rfc = RFC6979KCalculator(S256Point.n, d, zInt);
      BigInt hash = rfc.nextK();
      String hashDec = '20889311776560637325212081170397242351715008433244209396146804465420672466763';
      expect(hash, equals(BigInt.parse(hashDec, radix: 10)));
    });

    test('Sign', () {
      String prHex = '5dcdf7f183a5811fd0db5afc96d843e5ea6d1b26c960612cca907eeb7dfd1694';
      BigInt d = BigInt.parse(prHex, radix: 16);

      String msg = '4065ee77813c4b8ea4b67c55a1930cc64fbacef0e2f1bee091c275cf84059c31';
      BigInt z = BigInt.parse(msg, radix: 16);

      PrivateKey pk = PrivateKey(d);

      Signature sig = pk.sign(z);

      String rDec = '87342768201447912050621036474077457990029954729815919484425005130027088751047';
      String sDec = '20554016548608470664410225175851970959219277773678507382186547909134298312666';
      expect(sig.r, BigInt.parse(rDec, radix: 10));
      expect(sig.s, BigInt.parse(sDec, radix: 10));
    });

    test('Verify', () {
      String prHex = '5dcdf7f183a5811fd0db5afc96d843e5ea6d1b26c960612cca907eeb7dfd1694';
      BigInt d = BigInt.parse(prHex, radix: 16);

      String msg = '4065ee77813c4b8ea4b67c55a1930cc64fbacef0e2f1bee091c275cf84059c31';
      BigInt z = BigInt.parse(msg, radix: 16);

      PrivateKey pk = PrivateKey(d);

      Signature sig = pk.sign(z);

      expect(pk.point.verify(z, sig), equals(true));
    });
  });
}
