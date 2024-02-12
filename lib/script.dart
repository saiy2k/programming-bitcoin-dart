import 'dart:typed_data';

import 'package:dart_bitcoin/helpers/hex.dart';
import 'package:dart_bitcoin/helpers/varint.dart';
import 'package:dart_bitcoin/script/opcode.dart';

abstract class ScriptCmd {}

class OperationCmd extends ScriptCmd {
  final OpCode operation;
  OperationCmd(this.operation);

  String toStr(String type) {
    return operation.toStr(type);
  }

  @override
  String toString() {
    return toStr('');
  }
}

class ElementCmd extends ScriptCmd {
  final Uint8List element;
  ElementCmd(this.element);

  @override
  String toString() {
    return uint8ListToHex(element);
  }
}

class Script {
  late List<ScriptCmd> cmds;

  static int parseIndex = 0;

  Script(this.cmds);

  String serialize() {
    String result = '';
    for (var cmd in cmds) {
      if (cmd is OperationCmd) {
        result += cmd.operation.toStr('hex');
      } else if (cmd is ElementCmd) {
        result += cmd.element.length.toRadixString(16);
        result += uint8ListToHex(cmd.element);
        // TODO: OP_PUSHDATA1
        // TODO: OP_PUSHDATA2
        // TODO: OP_PUSHDATA4
      }
    }

    String scriptLen = uint8ListToHex(encodeVarint(BigInt.from(result.length ~/ 2)));
    return scriptLen + result;
  }

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
        // TODO: OP_PUSHDATA1
        // TODO: OP_PUSHDATA2
        // TODO: OP_PUSHDATA4
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

  @override
  String toString() {
    String result = '';
    for (var cmd in cmds) {
      if (cmd is OperationCmd) {
        result += '$cmd ';
      } else if (cmd is ElementCmd) {
        result += '$cmd ';
      }
    }
    return result;
  }
}
