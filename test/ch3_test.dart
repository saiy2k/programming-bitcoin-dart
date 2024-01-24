import 'package:dart_bitcoin/field_element.dart';
import 'package:dart_bitcoin/point.dart';
import 'package:dart_bitcoin/s_256_field.dart';
import 'package:dart_bitcoin/s_256_point.dart';
import 'package:test/test.dart';

import 'const_nos.dart';

//      BigInt gx = BigInt.parse('79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798', radix: 16);
//      BigInt gy = BigInt.parse('483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8', radix: 16);

void main() {
  BigInt prime = BigInt.from(223);
  group('Ch3: Elliptic curve cryptography (ECC)', () {
    test('Ex1: Points on curve y^2 = x^3 + 7 over F233; (192, 105), (17, 56), (200, 119), (1, 193), (42, 99)', () {
      FieldElement a = FieldElement(i0, i223);
      FieldElement b = FieldElement(i7, i223);

      FieldElement fe192 = FieldElement(i192, i223);
      FieldElement fe105 = FieldElement(i105, i223);
      Point p1 = Point(fe192, fe105, a, b);
      expect(p1, isNotNull);

      FieldElement fe17 = FieldElement(i17, i223);
      FieldElement fe56 = FieldElement(i56, i223);
      Point p2 = Point(fe17, fe56, a, b);
      expect(p2, isNotNull);

      FieldElement fe200 = FieldElement(i200, i223);
      FieldElement fe119 = FieldElement(i119, i223);
      expect(() => Point(fe200, fe119, a, b), throwsArgumentError);

      FieldElement fe1 = FieldElement(i1, i223);
      FieldElement fe193 = FieldElement(i193, i223);
      Point p4 = Point(fe1, fe193, a, b);
      expect(p4, isNotNull);

      FieldElement fe42 = FieldElement(i42, i223);
      FieldElement fe99 = FieldElement(i99, i223);
      expect(() => Point(fe42, fe99, a, b), throwsArgumentError);
    });
  });
}
