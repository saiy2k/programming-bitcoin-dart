import 'package:dart_bitcoin/helpers/hex.dart';

class OpCode {
  final int value;

  OpCode(this.value);

  static OpCode OP_0 = OpCode(0x00);
  static OpCode OP_1 = OpCode(0x51);
  static OpCode OP_2 = OpCode(0x52);
  static OpCode OP_3 = OpCode(0x53);
  static OpCode OP_4 = OpCode(0x54);
  static OpCode OP_5 = OpCode(0x55);
  static OpCode OP_6 = OpCode(0x56);
  static OpCode OP_7 = OpCode(0x57);
  static OpCode OP_8 = OpCode(0x58);
  static OpCode OP_9 = OpCode(0x59);
  static OpCode OP_10 = OpCode(0x5a);
  static OpCode OP_11 = OpCode(0x5b);
  static OpCode OP_12 = OpCode(0x5c);
  static OpCode OP_13 = OpCode(0x5d);
  static OpCode OP_14 = OpCode(0x5e);
  static OpCode OP_15 = OpCode(0x5f);
  static OpCode OP_16 = OpCode(0x60);

  static OpCode OP_DUP = OpCode(0x76);
  static OpCode OP_EQUAL_VERIFY = OpCode(0x88);
  static OpCode OP_HASH256 = OpCode(0xaa);
  static OpCode OP_CHECKSIG = OpCode(0xac);
  static OpCode OP_HASH160 = OpCode(0xa9);

  static const Map<int, String> _names = {
    0x00: "OP_0",
    0X51: "OP_1",
    0x52: "OP_2",
    0x53: "OP_3",
    0x54: "OP_4",
    0x55: "OP_5",
    0x56: "OP_6",
    0x57: "OP_7",
    0x58: "OP_8",
    0x59: "OP_9",
    0x5a: "OP_10",
    0x5b: "OP_11",
    0x5c: "OP_12",
    0x5d: "OP_13",
    0x5e: "OP_14",
    0x5f: "OP_15",
    0x60: "OP_16",
    0x76: "OP_DUP",
    0x88: "OP_EQUALVERIFY",
    0xaa: "OP_HASH256",
    0xac: "OP_CHECKSIG",
    0xa9: "OP_HASH160",
  };

  // static const List<OpCode> values = [OP_DUP, OP_HASH256, OP_HASH160];
  @override
  String toString() {
    return toStr('');
  }

  String toStr(String type) {
    if (type == 'no') {
      return '$value';
    } else if (type == 'hex') {
      return value.toRadixString(16);
    } else {
      return _names[value]!;
    }
  }
}
