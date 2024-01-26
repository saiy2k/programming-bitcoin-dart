import 'dart:math';

import 'package:dart_bitcoin/ecc/field_element.dart';
import 'package:dart_bitcoin/ecc/operable.dart';

class Point<T extends IOperable> {
  FieldElement? x, y;
  FieldElement a, b;

  Point(this.x, this.y, this.a, this.b) {
    if (x == null && y == null) {
      return;
    }
    if (x == null || y == null) {
      throw ArgumentError('Both (x, y) must be null or not null');
    }

    if (!onCurve(x!, y!)) {
      throw ArgumentError('($x, $y) is not on the curve');
    }
  }

  static Point inifinity<T extends IOperable>(FieldElement a, FieldElement b) {
    return Point(null, null, a, b);
  }

  Point operator +(Point other) {
    if (a != other.a || b != other.b) {
      throw ArgumentError('Points $this and $other are not on the same curve');
    }

    // Vertical tangent
    if (this == other && y?.num == 0) {
      return Point(null, null, a, b);
    }

    // Point at infinity
    if (x == other.x && y != other.y) {
      return Point(null, null, a, b);
    }

    if (x == null) {
      return other;
    }

    if (other.x == null) {
      return this;
    }

    if (x != other.x) {
      FieldElement s = (other.y! - y!) / (other.x! - x!);
      FieldElement x3 = (s * s) - x! - other.x!;
      FieldElement y3 = s * (x! - x3) - y!;
      return Point(x3, y3, a, b);
    }

    if (x == other.x) {
      FieldElement fe3 = FieldElement(BigInt.from(3), a.prime);
      FieldElement fe2 = FieldElement(BigInt.two, a.prime);

      FieldElement s = (fe3 * x! * x! + a) / (fe2 * y!);
      FieldElement x3 = (s * s) - fe2 * x!;
      FieldElement y3 = s * (x! - x3) - y!;

      return Point(x3, y3, a, b);
    }

    return Point(x, y, a, b);
  }

  Point smult(BigInt coeff) {
    Point current = this;
    Point result = Point(null, null, this.a, this.b);

    while (coeff > BigInt.zero) {
      if (coeff & BigInt.one == BigInt.one) {
        result = result + current;
      }

      current = current + current;
      coeff = coeff >> 1;
    }

    return result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y &&
          a == other.a &&
          b == other.b;

  bool onCurve(FieldElement x, FieldElement y) {
    return y.pow(BigInt.two) == x.pow(BigInt.from(3)) + a * x + b;
  }

  @override
  int get hashCode {
    int hash = 17;
    hash = 31 * hash + a.hashCode;
    hash = 31 * hash + b.hashCode;
    hash = 31 * hash + x.hashCode;
    hash = 31 * hash + y.hashCode;
    return hash;
  }

  @override
  String toString() {
    if (x == null) {
      return "Point(infinity)";
    } else {
      return "Point($x, $y)_${a}_$b";
    }
  }
}
