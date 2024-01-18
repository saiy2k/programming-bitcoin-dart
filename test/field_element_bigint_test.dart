import 'package:dart_bitcoin/field_element.dart';
import 'package:test/test.dart';

import 'const_nos.dart';

void main() {
  group('FieldElement', () {
    test('Basic: Initialization', () {
      FieldElement a = FieldElement(i7, i13);
      expect(a.num, equals(i7));
      expect(a.prime, equals(i13));
    });

    test('Basic: Negative Initialization', () {
      FieldElement a = FieldElement.fromNegative(im4, i13);
      expect(a.num, equals(i9));
      expect(a.prime, equals(i13));
    });

    test('Basic: Throws error with invalid num', () {
      expect(() => FieldElement(im1, i13), throwsArgumentError);
      expect(() => FieldElement(i13, i13), throwsArgumentError);
    });

    test('Basic: Equality check', () {
      FieldElement a = FieldElement(i7, i13);
      FieldElement b = FieldElement(i7, i13);
      FieldElement c = FieldElement(i6, i13);

      expect(a == b, isTrue);
      expect(a != c, isTrue);
      expect(a == c, isFalse);
      expect(b == c, isFalse);

      expect(a, equals(b));
      expect(b, isNot(equals((c))));
    });

    test('Add, Sub: Case 1', () {
      FieldElement fe44 = FieldElement(i44, i57);
      FieldElement fe33 = FieldElement(i33, i57);
      FieldElement fe20 = FieldElement(i20, i57);

      expect(fe44 + fe33, equals(fe20));
    });

    test('Add, Sub: Case 2', () {
      FieldElement fe9 = FieldElement(i9, i57);
      FieldElement fe29 = FieldElement(i29, i57);
      FieldElement fe37 = FieldElement(i37, i57);

      expect(fe9 - fe29, equals(fe37));
    });

    test('Add, Sub: Case 3', () {
      FieldElement fe17 = FieldElement(i17, i57);
      FieldElement fe42 = FieldElement(i42, i57);
      FieldElement fe49 = FieldElement(i49, i57);
      FieldElement fe51 = FieldElement(i51, i57);

      expect(fe17 + fe42 + fe49, equals(fe51));
    });

    test('Add, Sub: Case 4', () {
      FieldElement fe52 = FieldElement(i52, i57);
      FieldElement fe30 = FieldElement(i30, i57);
      FieldElement fe38 = FieldElement(i38, i57);
      FieldElement fe41 = FieldElement(i41, i57);

      expect(fe52 - fe30 - fe38, equals(fe41));
    });

    test('Add: Error', () {
      FieldElement fe7 = FieldElement(i7, i13);
      FieldElement fe8 = FieldElement(i8, i15);

      expect(() => fe7 + fe8, throwsArgumentError);
    });

    test('Sub: Error', () {
      FieldElement fe7 = FieldElement(i7, i13);
      FieldElement fe8 = FieldElement(i8, i15);

      expect(() => fe7 - fe8, throwsArgumentError);
    });

    test('Mul, Exp: Case 1', () {
      FieldElement fe95 = FieldElement(i95, i97);
      FieldElement fe45 = FieldElement(i45, i97);
      FieldElement fe31 = FieldElement(i31, i97);
      FieldElement fe23 = FieldElement(i23, i97);

      expect(fe95 * fe45 * fe31, equals(fe23));
    });

    test('Mul, Exp: Case 2', () {
      FieldElement fe17 = FieldElement(i17, i97);
      FieldElement fe13 = FieldElement(i13, i97);
      FieldElement fe19 = FieldElement(i19, i97);
      FieldElement fe44 = FieldElement(i44, i97);
      FieldElement fe68 = FieldElement(i68, i97);

      expect(fe17 * fe13 * fe19 * fe44, equals(fe68));
    });
    test('Mul, Exp: Case 3', () {
      FieldElement fe12 = FieldElement(i12, i97);
      FieldElement fe77 = FieldElement(i77, i97);
      FieldElement fe63 = FieldElement(i63, i97);

      expect(fe12.pow_(i7) * fe77.pow_(i49), equals(fe63));
    });

    test('Div: Case 1', () {
      FieldElement fe3 = FieldElement(i3, i31);
      FieldElement fe24 = FieldElement(i24, i31);
      FieldElement fe4 = FieldElement(i4, i31);

      expect(fe3 / fe24, equals(fe4));
    });

    test('Div: Case 2', () {
      FieldElement fe17 = FieldElement(i17, i31);
      FieldElement fe29 = FieldElement(i29, i31);

      expect(fe17.pow_(im3), equals(fe29));
    });

    test('Div: Case 3', () {
      FieldElement fe4 = FieldElement(i4, i31);
      FieldElement fe11 = FieldElement(i11, i31);
      FieldElement fe13 = FieldElement(i13, i31);

      expect(fe4.pow_(im4) * fe11, equals(fe13));
    });
  });
}
