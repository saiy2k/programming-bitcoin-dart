import 'dart:typed_data';

import 'package:dart_bitcoin/helpers/varint.dart';

class TxOut {
  late BigInt amount;
  late String script_pubkey;

  static int parseIndex = 0;

  TxOut(this.amount, this.script_pubkey);

  TxOut.fromBytes(Uint8List txBytes, int bI) {
    amount = BigInt.from(txBytes[bI] +
        (txBytes[bI + 1] << 8) +
        (txBytes[bI + 2] << 16) +
        (txBytes[bI + 3] << 24) +
        (txBytes[bI + 4] << 32) +
        (txBytes[bI + 5] << 40) +
        (txBytes[bI + 6] << 48) +
        (txBytes[bI + 7] << 56));
    bI = bI + 8;

    BigInt scriptPubKeyLength;
    (scriptPubKeyLength, bI) = decodeVarint(txBytes, bI);
    script_pubkey =
        txBytes.getRange(bI, bI + scriptPubKeyLength.toInt()).map((e) => e.toRadixString(16).padLeft(2, '0')).join('');
    bI = bI + scriptPubKeyLength.toInt();

    parseIndex = bI;
  }

  static (TxOut, int) parseFromBytes(Uint8List txBytes, int bI) {
    parseIndex = bI;
    TxOut tx = TxOut.fromBytes(txBytes, bI);
    return (tx, parseIndex);
  }

  @override
  String toString() {
    return '$amount:$script_pubkey';
  }
}
