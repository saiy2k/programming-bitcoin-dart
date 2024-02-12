import 'dart:typed_data';

import 'package:dart_bitcoin/helpers/varint.dart';
import 'package:dart_bitcoin/script/opcode.dart';

abstract class ScriptCmd {}

class OperationCmd extends ScriptCmd {
  final OpCode operation;
  OperationCmd(this.operation);

  String toStr(String type) {
    return operation.toStr(type);
  }

  String toString() {
    return operation.toStr('');
  }
}

class ElementCmd extends ScriptCmd {
  final Uint8List element;
  ElementCmd(this.element);
}

class Script {
  late List<ScriptCmd> cmds;

  static int parseIndex = 0;

  Script(this.cmds);

  Script.fromBytes(Uint8List txBytes, int bI) {
    BigInt scriptLength;
    (scriptLength, bI) = decodeVarint(txBytes, bI);

    cmds = [];
    int count = 0;
    int length = scriptLength.toInt();

    while (count < length) {
      int current = txBytes[bI];
      count++;
      bI++;

      // data range between 1-75 bytes
      if (current >= 0x01 && current <= 0x4b) {
        int n = current;
        cmds.add(ElementCmd(Uint8List.fromList(txBytes.getRange(bI, bI + n).toList())));
        count += n;
        bI = bI + n;
      } else {
        cmds.add(OperationCmd(OpCode(current)));
      }
    }

    parseIndex = bI;
  }

  static (Script, int) parseFromBytes(Uint8List txBytes, int bI) {
    parseIndex = bI;
    Script script = Script.fromBytes(txBytes, bI);
    return (script, parseIndex);
  }

  String toString() {
    String result = '';
    for (var cmd in cmds) {
      if (cmd is OperationCmd) {
        result += '${cmd.operation.toString()} ';
      } else if (cmd is ElementCmd) {
        result += '${cmd.element} ';
      }
    }
    return result;
  }
}
