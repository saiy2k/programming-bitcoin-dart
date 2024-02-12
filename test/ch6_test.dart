import 'dart:typed_data';

import 'package:dart_bitcoin/helpers/hex.dart';
import 'package:dart_bitcoin/script.dart';
import 'package:dart_bitcoin/script/opcode.dart';
import 'package:dart_bitcoin/script/operations.dart';
import 'package:test/test.dart';

void main() {
  group('Ch6: Script', () {
    test('op_dup', () {
      OpCode op = OpCode.OP_DUP;
      List<int> stack = List.from([20, 30, 40]);

      bool success = operations[op]!(stack);

      expect(success, isTrue);
      // expect(stack.length, equals(4));
      expect(stack, equals(List.from([20, 30, 40, 40])));
    });

    test('op_has256', () {
      OpCode op = OpCode.OP_HASH256;
      List<int> stack = List.from([20, 30, 40]);

      bool success = operations[op]!(stack);

      expect(success, isTrue);
      expect(stack.length, equals(3));
      // expect(stack, equals(List.from([20, 30, ])));
    });

    // OP_DUP OP_HASH160 ab0c0b2e98b1ab6dbf67d4750b0a56244948a879 OP_EQUALVERIFY OP_CHECKSIG
    // 76 a9 14 ab0c0b2e98b1ab6dbf67d4750b0a56244948a879 88 ac

    test('script parse', () {
      String scriptString = '1976a914ab0c0b2e98b1ab6dbf67d4750b0a56244948a87988ac';
      Uint8List scriptBytes = hexStringToBytes(scriptString);
      int baseIndex = 0;
      Script script;
      (script, baseIndex) = Script.parseFromBytes(scriptBytes, baseIndex);
      print(script);
    });
  });
}
