import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:dart_bitcoin/ecc/s_256_point.dart';
import 'package:dart_bitcoin/helpers/bigint_util.dart';
import 'package:dart_bitcoin/helpers/hex.dart';
import 'package:dart_bitcoin/helpers/uint8list.dart';
import 'package:dart_bitcoin/helpers/varint.dart';
import 'package:dart_bitcoin/tx/tx_in.dart';
import 'package:dart_bitcoin/tx/tx_out.dart';

enum ParseStep { version, txIn, txOut, locktime }

class Tx {
  int version;
  List<TxIn> txIns;
  List<TxOut> txOuts;
  int locktime;
  bool testnet;

  Tx(this.version, this.txIns, this.txOuts, this.locktime, this.testnet) {}

  String id() {
    return uint8ListToHex(hash());
  }

  @override
  String toString() {
    String tInputs = txIns.map((e) => e.toString()).join("\n");
    String tOutputs = txOuts.map((e) => e.toString()).join("\n");
    return "tx: ${this.id}\nversion: ${this.version}\ntx_ints: $tInputs\ntx_outs: $tOutputs\nlocktime: ${this.locktime}\n";
  }

  Uint8List hash() {
    // hash256(serialize(this))
    return Uint8List.fromList([0, 1, 2, 3, 4, 5]);
  }

  String serialize() {
    String versionString = serializeVersion();
    String txInString = serializeTxIns();
    String txOutString = serializeTxOuts();
    String lockTimeString = uint8ListToHex(intToUint8ListLittle(locktime));

    return versionString + txInString + txOutString + lockTimeString;
  }

  String serializeVersion() {
    String versionString = uint8ListToHex(intToUint8ListLittle(version));
    return versionString;
  }

  String serializeTxIns() {
    String txInCountString = uint8ListToHex(encodeVarint(BigInt.from(txIns.length)));
    String txInString = "";
    for (TxIn txIn in txIns) {
      txInString = txInString + txIn.serialize();
    }
    return txInCountString + txInString;
  }

  String serializeTxOuts() {
    String txOutCountString = uint8ListToHex(encodeVarint(BigInt.from(txOuts.length)));
    String txOutString = "";
    for (TxOut txOut in txOuts) {
      txOutString = txOutString + txOut.serialize();
    }
    return txOutCountString + txOutString;
  }

  /// 4 bytes: Version
  /// Inputs
  /// Outputs
  /// 4 bytes: Locktime
  parse(Uint8List txBytes) {
    int baseIndex = 0;
    int _version;
    int _lockTime;
    List<TxIn> _txIns;
    List<TxOut> _txOuts;

    (_version, baseIndex) = parseVersion(txBytes, baseIndex);
    version = _version;

    (_txIns, baseIndex) = parseInputTxs(txBytes, baseIndex);
    txIns = _txIns;

    (_txOuts, baseIndex) = parseOutputTxs(txBytes, baseIndex);
    txOuts = _txOuts;

    (_lockTime, baseIndex) = parseLocktime(txBytes, baseIndex);
    locktime = _lockTime;
  }

  (int, int) parseVersion(Uint8List txBytes, int baseIndex) {
    int version = txBytes[0] + (txBytes[1] << 8) + (txBytes[2] << 16) + (txBytes[3] << 24);
    baseIndex = 4;
    return (version, baseIndex);
  }

  /// Varint: Input count
  /// Inputs
  (List<TxIn>, int) parseInputTxs(Uint8List txBytes, int baseIndex) {
    BigInt inputCount;
    List<TxIn> txIns = [];
    (inputCount, baseIndex) = decodeVarint(txBytes, baseIndex);

    for (BigInt i = BigInt.zero; i < inputCount; i = i + BigInt.one) {
      TxIn txIn;
      (txIn, baseIndex) = TxIn.parseFromBytes(txBytes, baseIndex);
      txIns.add(txIn);
    }
    return (txIns, baseIndex);
  }

  /// Varint: Output count
  /// Outputs
  (List<TxOut>, int) parseOutputTxs(Uint8List txBytes, int baseIndex) {
    BigInt outputCount;
    List<TxOut> txIns = [];
    (outputCount, baseIndex) = decodeVarint(txBytes, baseIndex);

    for (BigInt i = BigInt.zero; i < outputCount; i = i + BigInt.one) {
      TxOut txOut;
      (txOut, baseIndex) = TxOut.parseFromBytes(txBytes, baseIndex);
      txIns.add(txOut);
    }
    return (txIns, baseIndex);
  }

  (int, int) parseLocktime(Uint8List txBytes, int bI) {
    int version = txBytes[bI] + (txBytes[bI + 1] << 8) + (txBytes[bI + 2] << 16) + (txBytes[bI + 3] << 24);
    return (version, bI + 4);
  }

  /* Stream version 
  /// 4 bytes: Version
  /// Variant: # of inputs
  parse(Stream<int> txStream) {
    ParseStep step = ParseStep.version;
    int count = 0;
    int inputCount = 0;
    StreamSubscription<int>? byteSub;
    byteSub = txStream.listen((int byte) {
      print(byte);
      if (step == ParseStep.version) {
        version = version + (byte << ((count + 1) * 8));
        count++;

        if (count == 4) {
          step = ParseStep.txIn;
          count = 0;
        }
      } else if (step == ParseStep.txIn) {
        bool isVariantDone = parseVariant(inputCount, byte);
        // print(byte);
        count++;
      }

      if (count > 10) {
        byteSub?.cancel();
      }
    });
  }
  */
}
