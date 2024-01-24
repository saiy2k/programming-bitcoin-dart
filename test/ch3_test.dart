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
      // (192, 105)
      FieldElement fe192 = FieldElement(i192, i223);
      FieldElement fe105 = FieldElement(i105, i223);
      Point p1 = Point(fe192, fe105, feA, feB);
      expect(p1, isNotNull);

      // (17, 56)
      FieldElement fe17 = FieldElement(i17, i223);
      FieldElement fe56 = FieldElement(i56, i223);
      Point p2 = Point(fe17, fe56, feA, feB);
      expect(p2, isNotNull);

      // (200, 119)
      FieldElement fe200 = FieldElement(i200, i223);
      FieldElement fe119 = FieldElement(i119, i223);
      expect(() => Point(fe200, fe119, feA, feB), throwsArgumentError);

      // (1, 193)
      FieldElement fe1 = FieldElement(i1, i223);
      FieldElement fe193 = FieldElement(i193, i223);
      Point p4 = Point(fe1, fe193, feA, feB);
      expect(p4, isNotNull);

      // (42, 99)
      FieldElement fe42 = FieldElement(i42, i223);
      FieldElement fe99 = FieldElement(i99, i223);
      expect(() => Point(fe42, fe99, feA, feB), throwsArgumentError);
    });
    test('Ex2: (170, 142) + (60, 139); (47, 71) + (17, 56); (143, 98) + (76, 66) over F233', () {
      // (170, 142) + (60, 139)
      FieldElement fe170 = FieldElement(i170, i223);
      FieldElement fe142 = FieldElement(i142, i223);
      FieldElement fe60 = FieldElement(i60, i223);
      FieldElement fe139 = FieldElement(i139, i223);

      Point p1 = Point(fe170, fe142, feA, feB);
      Point p2 = Point(fe60, fe139, feA, feB);

      Point pSum1 = p1 + p2;

      expect(pSum1.x?.num, equals(i220));
      expect(pSum1.y?.num, equals(i181));

      // (47, 71) + (17, 56)
      FieldElement fe47 = FieldElement(i47, i223);
      FieldElement fe71 = FieldElement(i71, i223);
      FieldElement fe17 = FieldElement(i17, i223);
      FieldElement fe56 = FieldElement(i56, i223);

      Point p3 = Point(fe47, fe71, feA, feB);
      Point p4 = Point(fe17, fe56, feA, feB);

      Point pSum2 = p3 + p4;

      expect(pSum2.x?.num, equals(i215));
      expect(pSum2.y?.num, equals(i68));

      // (143, 98) + (76, 66)
      FieldElement fe143 = FieldElement(i143, i223);
      FieldElement fe98 = FieldElement(i98, i223);
      FieldElement fe76 = FieldElement(i76, i223);
      FieldElement fe66 = FieldElement(i66, i223);

      Point p5 = Point(fe143, fe98, feA, feB);
      Point p6 = Point(fe76, fe66, feA, feB);

      Point pSum3 = p5 + p6;

      expect(pSum3.x?.num, equals(i47));
      expect(pSum3.y?.num, equals(i71));
    });
    test('Ex4: 2 * (192, 105); 2 * (143, 98); 2 * (47, 71); 4 * (47, 71); 8 * (47, 71); 21 * (47, 71); over F233', () {
      // 2 * (192, 105)
      FieldElement fe192 = FieldElement(i192, i223);
      FieldElement fe105 = FieldElement(i105, i223);

      Point p1 = Point(fe192, fe105, feA, feB);
      Point prod = p1.smult(BigInt.two);

      expect(prod.x?.num, equals(i49));
      expect(prod.y?.num, equals(i71));

      // 2 * (143, 98)
      FieldElement fe143 = FieldElement(i143, i223);
      FieldElement fe98 = FieldElement(i98, i223);

      Point p2 = Point(fe143, fe98, feA, feB);
      Point prod2 = p2.smult(BigInt.two);

      expect(prod2.x?.num, equals(i64));
      expect(prod2.y?.num, equals(i168));

      // 2 * (47, 71)
      FieldElement fe47 = FieldElement(i47, i223);
      FieldElement fe71 = FieldElement(i71, i223);

      Point p3 = Point(fe47, fe71, feA, feB);
      Point prod3 = p3.smult(BigInt.two);

      expect(prod3.x?.num, equals(i36));
      expect(prod3.y?.num, equals(i111));

      // 4 * (47, 71)
      Point prod4 = p3.smult(i4);

      expect(prod4.x?.num, equals(i194));
      expect(prod4.y?.num, equals(i51));

      // 8 * (47, 71)
      Point prod5 = p3.smult(i8);

      expect(prod5.x?.num, equals(i116));
      expect(prod5.y?.num, equals(i55));

      // 21 * (47, 71)
      Point prod6 = p3.smult(i21);

      expect(prod6.x?.num, isNull);
      expect(prod6.y?.num, isNull);
    });
  });
}
