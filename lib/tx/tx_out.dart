import 'dart:typed_data';

import 'package:dart_bitcoin/helpers/bigint_util.dart';
import 'package:dart_bitcoin/helpers/hex.dart';
import 'package:dart_bitcoin/helpers/uint8list.dart';
import 'package:dart_bitcoin/helpers/varint.dart';

/// 8 bytes: amount
/// 1-9 bytes: script_pubkey length
/// ? bytes: script_pubkey
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

  String serialize() {
    Uint8List amountBytes = writeBigInt(amount);
    print(amountBytes);
    String amountString = uint8ListToHex(Uint8List.fromList(writeBigInt(amount).reversed.toList())).padRight(16, '0');
    String pubKeyLength = uint8ListToHex(encodeVarint(BigInt.from(script_pubkey.length ~/ 2)));

    return amountString + pubKeyLength + script_pubkey;
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
