import 'package:dart_bitcoin/ecc/field_element.dart';
import 'package:test/test.dart';

/*
void main() {
  group('FieldElement', () {
    test('Basic: Initialization', () {
      FieldElement a = FieldElement(7, 13);
      expect(a.num, equals(7));
      expect(a.prime, equals(13));
    });

    test('Basic: Negative Initialization', () {
      FieldElement a = FieldElement.fromNegative(-4, 13);
      expect(a.num, equals(9));
      expect(a.prime, equals(13));
    });

    test('Basic: Throws error with invalid num', () {
      expect(() => FieldElement(-1, 13), throwsArgumentError);
      expect(() => FieldElement(13, 13), throwsArgumentError);
    });

    test('Basic: Equality check', () {
      FieldElement a = FieldElement(7, 13);
      FieldElement b = FieldElement(7, 13);
      FieldElement c = FieldElement(6, 13);

      expect(a == b, isTrue);
      expect(a != c, isTrue);
      expect(a == c, isFalse);
      expect(b == c, isFalse);

      expect(a, equals(b));
      expect(b, isNot(equals((c))));
    });

    test('Add, Sub: Case 1', () {
      FieldElement fe44 = FieldElement(44, 57);
      FieldElement fe33 = FieldElement(33, 57);
      FieldElement fe20 = FieldElement(20, 57);

      expect(fe44 + fe33, equals(fe20));
    });

    test('Add, Sub: Case 2', () {
      FieldElement fe9 = FieldElement(9, 57);
      FieldElement fe29 = FieldElement(29, 57);
      FieldElement fe37 = FieldElement(37, 57);

      expect(fe9 - fe29, equals(fe37));
    });

    test('Add, Sub: Case 3', () {
      FieldElement fe17 = FieldElement(17, 57);
      FieldElement fe42 = FieldElement(42, 57);
      FieldElement fe49 = FieldElement(49, 57);
      FieldElement fe51 = FieldElement(51, 57);

      expect(fe17 + fe42 + fe49, equals(fe51));
    });

    test('Add, Sub: Case 4', () {
      FieldElement fe52 = FieldElement(52, 57);
      FieldElement fe30 = FieldElement(30, 57);
      FieldElement fe38 = FieldElement(38, 57);
      FieldElement fe41 = FieldElement(41, 57);

      expect(fe52 - fe30 - fe38, equals(fe41));
    });

    test('Add: Error', () {
      FieldElement fe7 = FieldElement(7, 13);
      FieldElement fe8 = FieldElement(8, 15);

      expect(() => fe7 + fe8, throwsArgumentError);
    });

    test('Sub: Error', () {
      FieldElement fe7 = FieldElement(7, 13);
      FieldElement fe8 = FieldElement(8, 15);

      expect(() => fe7 - fe8, throwsArgumentError);
    });

    test('Mul, Exp: Case 1', () {
      FieldElement fe95 = FieldElement(95, 97);
      FieldElement fe45 = FieldElement(45, 97);
      FieldElement fe31 = FieldElement(31, 97);
      FieldElement fe23 = FieldElement(23, 97);

      expect(fe95 * fe45 * fe31, equals(fe23));
    });

    test('Mul, Exp: Case 2', () {
      FieldElement fe17 = FieldElement(17, 97);
      FieldElement fe13 = FieldElement(13, 97);
      FieldElement fe19 = FieldElement(19, 97);
      FieldElement fe44 = FieldElement(44, 97);
      FieldElement fe68 = FieldElement(68, 97);

      expect(fe17 * fe13 * fe19 * fe44, equals(fe68));
    });
    test('Mul, Exp: Case 3', () {
      FieldElement fe12 = FieldElement(12, 97);
      FieldElement fe77 = FieldElement(77, 97);
      FieldElement fe63 = FieldElement(63, 97);

      expect(fe12.pow_(7) * fe77.pow_(49), equals(fe63));
    });

    test('Div: Case 1', () {
      FieldElement fe3 = FieldElement(3, 31);
      FieldElement fe24 = FieldElement(24, 31);
      FieldElement fe4 = FieldElement(4, 31);

      expect(fe3 / fe24, equals(fe4));
    });

    test('Div: Case 2', () {
      FieldElement fe17 = FieldElement(17, 31);
      FieldElement fe29 = FieldElement(29, 31);

      expect(fe17.pow_(-3), equals(fe29));
    });

    test('Div: Case 3', () {
      FieldElement fe4 = FieldElement(4, 31);
      FieldElement fe11 = FieldElement(11, 31);
      FieldElement fe13 = FieldElement(13, 31);

      expect(fe4.pow_(-4) * fe11, equals(fe13));
    });
  });
}
*/