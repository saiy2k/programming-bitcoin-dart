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
