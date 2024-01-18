import 'package:dart_bitcoin/field_element.dart';
import 'package:dart_bitcoin/point.dart';
import 'package:test/test.dart';

import 'const_nos.dart';

void main() {
  BigInt prime = BigInt.from(223);
  group('Point', () {
    test('Basic: Initialization', () {
      FieldElement fe2 = FieldElement(i2, prime);
      FieldElement fe4 = FieldElement(i4, prime);
      FieldElement fe5 = FieldElement(i5, prime);
      FieldElement fe7 = FieldElement(i7, prime);
      expect(() => Point(fe2, fe4, fe5, fe7), throwsArgumentError);

      FieldElement fem1 = FieldElement.fromNegative(im1, prime);
      expect(Point(fem1, fem1, fe5, fe7), isA<Point>());

      FieldElement fe18 = FieldElement(i18, prime);
      FieldElement fe77 = FieldElement(i77, prime);
      expect(Point(fe18, fe77, fe5, fe7), isA<Point>());

      expect(() => Point(fe5, fe7, fe5, fe7), throwsArgumentError);
    });

    test('Basic: onCurve', () {
      FieldElement fem1 = FieldElement.fromNegative(im1, prime);
      FieldElement fe5 = FieldElement(i5, prime);
      FieldElement fe7 = FieldElement(i7, prime);
      Point p = Point(fem1, fem1, fe5, fe7);

      expect(p.onCurve(fem1, fem1), true);

      FieldElement fe2 = FieldElement(i2, prime);
      FieldElement fe4 = FieldElement(i4, prime);
      expect(p.onCurve(fe2, fe4), false);

      FieldElement fe18 = FieldElement(i18, prime);
      FieldElement fe77 = FieldElement(i77, prime);
      expect(p.onCurve(fe18, fe77), true);

      expect(p.onCurve(fe5, fe7), false);
    });

    test('Add: Inifinity', () {
      FieldElement fem1 = FieldElement.fromNegative(im1, prime);
      FieldElement fe1 = FieldElement(i1, prime);
      FieldElement fe5 = FieldElement(i5, prime);
      FieldElement fe7 = FieldElement(i7, prime);

      Point p1 = Point(fem1, fem1, fe5, fe7);
      Point p2 = Point(fem1, fe1, fe5, fe7);

      Point pInfinity = Point(null, null, fe5, fe7);

      expect(p1 + pInfinity, equals(p1));
      expect(pInfinity + p2, equals(p2));
    });

    test('Add: 2 points: (2, 5) + (-1, -1)', () {
      FieldElement fem1 = FieldElement.fromNegative(im1, prime);
      FieldElement fe2 = FieldElement(i2, prime);
      FieldElement fe5 = FieldElement(i5, prime);
      FieldElement fe7 = FieldElement(i7, prime);

      Point p1 = Point(fe2, fe5, fe5, fe7);
      Point p2 = Point(fem1, fem1, fe5, fe7);

      FieldElement fe3 = FieldElement(i3, prime);
      FieldElement fem7 = FieldElement.fromNegative(im7, prime);
      expect(p1 + p2, equals(Point(fe3, fem7, fe5, fe7)));
    });

    // TODO: Error in the book
    test('Add: 2 points: (-1, 1) + (-1, 1)', () {
      FieldElement fe1 = FieldElement(i1, prime);
      FieldElement fem1 = FieldElement.fromNegative(im1, prime);
      FieldElement fe5 = FieldElement(i5, prime);
      FieldElement fe7 = FieldElement(i7, prime);

      Point p1 = Point(fem1, fe1, fe5, fe7);
      Point p2 = Point(fem1, fe1, fe5, fe7);

      FieldElement fe18 = FieldElement(i18, prime);
      FieldElement fem77 = FieldElement.fromNegative(im77, prime);
      expect(p1 + p2, equals(Point(fe18, fem77, fe5, fe7)));
    });
  });
}
