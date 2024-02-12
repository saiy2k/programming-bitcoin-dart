import 'dart:typed_data';

import 'package:dart_bitcoin/helpers/crypto.dart';
import 'package:dart_bitcoin/helpers/uint8list.dart';

class OpCode {
  final int value;
  const OpCode._(this.value);

  static const OpCode OP_DUP = OpCode._(0x76);
  static const OpCode OP_HASH256 = OpCode._(0xaa);
  static const OpCode OP_HASH160 = OpCode._(0xa9);

  static const List<OpCode> values = [OP_DUP, OP_HASH256, OP_HASH160];

  @override
  String toString() {
    return '$value';
  }
}

Map<OpCode, Function> operations = {
  OpCode.OP_DUP: opDup,
  OpCode.OP_HASH256: opHash256,
  OpCode.OP_HASH160: opHash160,
};

bool opDup(List<int> stack) {
  if (stack.isEmpty) {
    return false;
  }
  stack.add(stack.last);
  return true;
}

bool opHash256(List<int> stack) {
  if (stack.isEmpty) {
    return false;
  }

  int e = stack.removeLast();
  stack.add(uint8ListToInt(hash256(intToUint8List(e))));
  return true;
}

bool opHash160(Uint8List stack) {
  if (stack.isEmpty) {
    return false;
  }
  int e = stack.removeLast();
  stack.add(uint8ListToInt(hash160(intToUint8List(e))));
  return true;
}
