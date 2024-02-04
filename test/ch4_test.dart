import 'dart:typed_data';

import 'package:dart_bitcoin/base58.dart';
import 'package:dart_bitcoin/ecc/rfc_6979.dart';
import 'package:dart_bitcoin/ecc/s_256_point.dart';
import 'package:dart_bitcoin/ecc/signature.dart';
import 'package:pointycastle/pointycastle.dart' hide PrivateKey, Signature;
import 'package:test/test.dart';

import 'package:dart_bitcoin/ecc/private_key.dart';

void main() {
  group('Ch4: Serialization', () {
    test('Ex1: Uncompressed SEC', () {
      PrivateKey pk1 = PrivateKey(BigInt.from(5000));
      Uint8List sec1 = pk1.point.sec(false);
      String expectedStr1 =
          '04ffe558e388852f0120e46af2d1b370f85854a8eb0841811ece0e3e03d282d57c315dc72890a4f10a1481c031b03b351b0dc79901ca18a00cf009dbdb157a1d10';
      expect(uint8ListToHex(sec1), equals(expectedStr1));

      BigInt i2018 = BigInt.from(2018);
      PrivateKey pk2 = PrivateKey(i2018.pow(5));
      Uint8List sec2 = pk2.point.sec(false);
      String expectedStr2 =
          '04027f3da1918455e03c46f659266a1bb5204e959db7364d2f473bdf8f0a13cc9dff87647fd023c13b4a4994f17691895806e1b40b57f4fd22581a4f46851f3b06';
      expect(uint8ListToHex(sec2), equals(expectedStr2));

      BigInt iHex = BigInt.parse('deadbeef12345', radix: 16);
      PrivateKey pk3 = PrivateKey(iHex);
      Uint8List sec3 = pk3.point.sec(false);
      String expectedStr3 =
          '04d90cd625ee87dd38656dd95cf79f65f60f7273b67d3096e68bd81e4f5342691f842efa762fd59961d0e99803c61edba8b3e3f7dc3a341836f97733aebf987121';
      expect(uint8ListToHex(sec3), equals(expectedStr3));
    });

    test('Ex2: Compressed SEC', () {
      PrivateKey pk1 = PrivateKey(BigInt.from(5001));
      Uint8List sec1 = pk1.point.sec(true);
      String expectedStr1 = '0357a4f368868a8a6d572991e484e664810ff14c05c0fa023275251151fe0e53d1';
      expect(uint8ListToHex(sec1), equals(expectedStr1));

      BigInt i2019 = BigInt.from(2019);
      PrivateKey pk2 = PrivateKey(i2019.pow(5));
      Uint8List sec2 = pk2.point.sec(true);
      String expectedStr2 = '02933ec2d2b111b92737ec12f1c5d20f3233a0ad21cd8b36d0bca7a0cfa5cb8701';
      expect(uint8ListToHex(sec2), equals(expectedStr2));

      BigInt iHex = BigInt.parse('deadbeef54321', radix: 16);
      PrivateKey pk3 = PrivateKey(iHex);
      Uint8List sec3 = pk3.point.sec(true);
      String expectedStr3 = '0296be5b1292f6c856b3c5654e886fc13511462059089cdf9c479623bfcbe77690';
      //print(uint8ListToHex(sec3));
      expect(uint8ListToHex(sec3), equals(expectedStr3));
    });

    test('Ex3: Find DER', () {
      BigInt r = BigInt.parse("37206a0610995c58074999cb9767b87af4c4978db68c06e8e6e81d282047a7c6", radix: 16);
      BigInt s = BigInt.parse("8ca63759c1157ebeaec0d03cecca119fc9a75bf8e6d0fa65c841c8e2738cdaec", radix: 16);

      Signature sig = Signature(r, s);
      String expectedDerHex =
          '3045022037206a0610995c58074999cb9767b87af4c4978db68c06e8e6e81d282047a7c60221008ca63759c1157ebeaec0d03cecca119fc9a75bf8e6d0fa65c841c8e2738cdaec';
      expect(uint8ListToHex(sig.der()), expectedDerHex);
    });

    test('Ex4: Base58', () {
      BigInt a = BigInt.parse('7c076ff316692a3d7eb3c3bb0f8b1488cf72e1afcd929e29307032997a838a3d', radix: 16);
      BigInt b = BigInt.parse('eff69ef2b1bd93a66ed5219add4fb51e11a840f404876325a1e8ffe0529a2c', radix: 16);
      BigInt c = BigInt.parse('c7207fee197d27c618aea621406f6bf5ef6fca38681d82b2f06fddbdce6feab6', radix: 16);

      String base58A = encodeBase58(writeBigInt(a));
      String base58B = encodeBase58(writeBigInt(b));
      String base58C = encodeBase58(writeBigInt(c));

      String expectedBase58A = '9MA8fRQrT4u8Zj8ZRd6MAiiyaxb2Y1CMpvVkHQu5hVM6';
      String expectedBase58B = '4fE3H2E6XMp4SsxtwinF7w9a34ooUrwWe4WsW1458Pd';
      String expectedBase58C = 'EQJsjkd6JaGwxrjEhfeqPenqHwrBmPQZjJGNSCHBkcF7';

      expect(base58A, equals(expectedBase58A));
      expect(base58B, equals(expectedBase58B));
      expect(base58C, equals(expectedBase58C));
    });
  });
}
