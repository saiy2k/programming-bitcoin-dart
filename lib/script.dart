import 'dart:typed_data';

import 'package:dart_bitcoin/helpers/crypto.dart';
import 'package:dart_bitcoin/helpers/uint8list.dart';

class OpCode {
  final int value;
  const OpCode._(this.value);

  static const OpCode OP_0 = OpCode._(0x00);
  static const OpCode OP_1 = OpCode._(0x51);
  static const OpCode OP_2 = OpCode._(0x52);
  static const OpCode OP_3 = OpCode._(0x53);
  static const OpCode OP_4 = OpCode._(0x54);
  static const OpCode OP_5 = OpCode._(0x55);
  static const OpCode OP_6 = OpCode._(0x56);
  static const OpCode OP_7 = OpCode._(0x57);
  static const OpCode OP_8 = OpCode._(0x58);
  static const OpCode OP_9 = OpCode._(0x59);
  static const OpCode OP_10 = OpCode._(0x5a);
  static const OpCode OP_11 = OpCode._(0x5b);
  static const OpCode OP_12 = OpCode._(0x5c);
  static const OpCode OP_13 = OpCode._(0x5d);
  static const OpCode OP_14 = OpCode._(0x5e);
  static const OpCode OP_15 = OpCode._(0x5f);
  static const OpCode OP_16 = OpCode._(0x60);

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
  OpCode.OP_0: op0,
  OpCode.OP_1: op1,
  OpCode.OP_2: op2,
  OpCode.OP_3: op3,
  OpCode.OP_4: op4,
  OpCode.OP_5: op5,
  OpCode.OP_6: op6,
  OpCode.OP_7: op7,
  OpCode.OP_8: op8,
  OpCode.OP_9: op9,
  OpCode.OP_10: op10,
  OpCode.OP_11: op11,
  OpCode.OP_12: op12,
  OpCode.OP_13: op13,
  OpCode.OP_14: op14,
  OpCode.OP_15: op15,
  OpCode.OP_16: op16,
  OpCode.OP_DUP: opDup,
  OpCode.OP_HASH256: opHash256,
  OpCode.OP_HASH160: opHash160,
};

bool op0(List<int> stack) {
  stack.add(0);
  return true;
}

bool op1(List<int> stack) {
  stack.add(1);
  return true;
}

bool op2(List<int> stack) {
  stack.add(2);
  return true;
}

bool op3(List<int> stack) {
  stack.add(3);
  return true;
}

bool op4(List<int> stack) {
  stack.add(4);
  return true;
}

bool op5(List<int> stack) {
  stack.add(5);
  return true;
}

bool op6(List<int> stack) {
  stack.add(6);
  return true;
}

bool op7(List<int> stack) {
  stack.add(7);
  return true;
}

bool op8(List<int> stack) {
  stack.add(8);
  return true;
}

bool op9(List<int> stack) {
  stack.add(9);
  return true;
}

bool op10(List<int> stack) {
  stack.add(10);
  return true;
}

bool op11(List<int> stack) {
  stack.add(11);
  return true;
}

bool op12(List<int> stack) {
  stack.add(12);
  return true;
}

bool op13(List<int> stack) {
  stack.add(13);
  return true;
}

bool op14(List<int> stack) {
  stack.add(14);
  return true;
}

bool op15(List<int> stack) {
  stack.add(15);
  return true;
}

bool op16(List<int> stack) {
  stack.add(16);
  return true;
}

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
