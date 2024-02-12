import 'dart:typed_data';

import 'package:dart_bitcoin/script.dart';
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
  });
}
