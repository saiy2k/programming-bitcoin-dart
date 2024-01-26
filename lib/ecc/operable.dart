import 'package:dart_bitcoin/ecc/field_element.dart';

abstract class IOperable {
  FieldElement operator +(FieldElement other);
  FieldElement operator -(FieldElement other);
  FieldElement operator *(FieldElement other);
  FieldElement operator /(FieldElement other);

  IOperable pow(BigInt exponent);
  IOperable smul(BigInt scalar);

  @override
  bool operator ==(Object other);

  @override
  int get hashCode;
}
