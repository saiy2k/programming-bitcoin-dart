import 'package:dart_bitcoin/helpers/crypto.dart';
import 'package:dart_bitcoin/helpers/uint8list.dart';

bool opHash256(List<int> stack) {
  if (stack.isEmpty) {
    return false;
  }

  int e = stack.removeLast();
  stack.add(uint8ListToInt(hash256(intToUint8List(e))));
  return true;
}
