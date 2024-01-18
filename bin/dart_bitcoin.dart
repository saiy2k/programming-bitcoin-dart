import 'package:dart_bitcoin/dart_bitcoin.dart' as dart_bitcoin;
import 'package:dart_bitcoin/field_element.dart';

void main(List<String> arguments) {
  print('Hello world: ${dart_bitcoin.calculate()}!');

  FieldElement a = FieldElement(BigInt.from(7), BigInt.from(13));
  print(a);

  FieldElement b = FieldElement(BigInt.from(15), BigInt.from(13));
}
