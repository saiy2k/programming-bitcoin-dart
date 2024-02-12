import 'package:dart_bitcoin/script/opcode.dart';
import 'package:dart_bitcoin/script/operations/numbers.dart';
import 'package:dart_bitcoin/script/operations/op_dup.dart';
import 'package:dart_bitcoin/script/operations/op_hash160.dart';
import 'package:dart_bitcoin/script/operations/op_hash256.dart';

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
