import 'dart:typed_data';

import 'package:dart_bitcoin/helpers/hex.dart';
import 'package:dart_bitcoin/helpers/uint8list.dart';
import 'package:dart_bitcoin/helpers/varint.dart';

// 32 bytes: prev_tx
// 4 bytes: prev_index
// 1-9 bytes: script_sig length
// ? bytes: script_sig
// 4 bytes: sequence
class TxIn {
  late String prev_tx;
  late int prev_index;
  late String script_sig;
  late int sequence;

  static int parseIndex = 0;

  TxIn(this.prev_tx, this.prev_index, this.script_sig, this.sequence);

  TxIn.fromBytes(Uint8List txBytes, int bI) {
    prev_tx = txBytes.getRange(bI, bI + 32).toList().map((e) => e.toRadixString(16).padLeft(2, '0')).join('');
    bI = bI + 32;

    prev_index = txBytes[bI] + (txBytes[bI + 1] << 8) + (txBytes[bI + 2] << 16) + (txBytes[bI + 3] << 24);
    bI = bI + 4;

    BigInt scriptSigLength;
    (scriptSigLength, bI) = decodeVarint(txBytes, bI);
    script_sig =
        txBytes.getRange(bI, bI + scriptSigLength.toInt()).map((e) => e.toRadixString(16).padLeft(2, '0')).join('');
    bI = bI + scriptSigLength.toInt();

    sequence = txBytes[bI] + (txBytes[bI + 1] << 8) + (txBytes[bI + 2] << 16) + (txBytes[bI + 3] << 24);
    bI = bI + 4;

    parseIndex = bI;
  }

  String serialize() {
    String prevIndexString = uint8ListToHex(intToUint8ListLittle(prev_index));
    String scriptSigLength = uint8ListToHex(encodeVarint(BigInt.from(script_sig.length ~/ 2)));
    String sequenceString = uint8ListToHex(intToUint8ListLittle(sequence));

    return prev_tx + prevIndexString + scriptSigLength + script_sig + sequenceString;
  }

  static (TxIn, int) parseFromBytes(Uint8List txBytes, int bI) {
    parseIndex = bI;
    TxIn tx = TxIn.fromBytes(txBytes, bI);
    return (tx, parseIndex);
  }

  @override
  String toString() {
    return '$prev_tx:$prev_index - $script_sig - $sequence';
  }

  parseScriptSig(Uint8List txBytes, int baseIndex) {}
}
