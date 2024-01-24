import 'package:dart_bitcoin/field_element.dart';

class S256Field extends FieldElement {
  static BigInt p = BigInt.two.pow(256) - BigInt.two.pow(32) - BigInt.from(977);

  S256Field(BigInt num) : super(num, p);
}
