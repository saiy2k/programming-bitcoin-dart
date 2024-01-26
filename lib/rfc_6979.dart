import 'package:crypto/crypto.dart';
import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/src/utils.dart' as utils;

// Ref:
//  https://github.com/bcgit/pc-dart/blob/6749f1ebe57f303d7455cc877b5991332e30e396/lib/signers/ecdsa_signer.dart#L283
//  https://pub.dev/packages/crypto
class RFC6979KCalculator {
  final Mac _mac;
  // late Hmac _mac;
  // ignore: non_constant_identifier_names
  late Uint8List _K;
  // ignore: non_constant_identifier_names
  late Uint8List _V;

  // S256Point.N
  final BigInt _n;

  // d is Private key
  RFC6979KCalculator(this._mac, this._n, BigInt d, Uint8List message) {
    _K = Uint8List(32);
    _V = Uint8List(32);
    _init(d, message);
  }

  void _init(BigInt d, Uint8List message) {
    _K.fillRange(0, _K.length, 0x00);
    _V.fillRange(0, _V.length, 0x01);

    var x = Uint8List((_n.bitLength + 7) ~/ 8);
    var dVal = _asUnsignedByteArray(d);

    x.setRange((x.length - dVal.length), x.length, dVal);

    var m = Uint8List((_n.bitLength + 7) ~/ 8);

    var mInt = _bitsToInt(message);

    if (mInt > _n) {
      mInt -= _n;
    }

    var mVal = _asUnsignedByteArray(mInt);

    m.setRange((m.length - mVal.length), m.length, mVal);

    _mac.init(KeyParameter(_K));
    // _mac = Hmac(sha256, _K);

    _mac.update(_V, 0, _V.length);
    _mac.updateByte(0x00);
    _mac.update(x, 0, x.length);
    _mac.update(m, 0, m.length);
    _mac.doFinal(_K, 0);

    _mac.init(KeyParameter(_K));
    // _mac = Hmac(sha256, _K);

    _mac.update(_V, 0, _V.length);
    _mac.doFinal(_V, 0);

    _mac.update(_V, 0, _V.length);
    _mac.updateByte(0x01);
    _mac.update(x, 0, x.length);
    _mac.update(m, 0, m.length);
    _mac.doFinal(_K, 0);

    _mac.init(KeyParameter(_K));
    // _mac = Hmac(sha256, _K);

    _mac.update(_V, 0, _V.length);
    _mac.doFinal(_V, 0);
  }

  BigInt nextK() {
    var t = Uint8List((_n.bitLength + 7) ~/ 8);

    for (;;) {
      var tOff = 0;

      while (tOff < t.length) {
        _mac.update(_V, 0, _V.length);
        _mac.doFinal(_V, 0);

        if ((t.length - tOff) < _V.length) {
          t.setRange(tOff, t.length, _V);
          tOff += (t.length - tOff);
        } else {
          t.setRange(tOff, tOff + _V.length, _V);
          tOff += _V.length;
        }
      }

      var k = _bitsToInt(t);

      // ignore: unrelated_type_equality_checks
      if ((k == 0) || (k >= _n)) {
        _mac.update(_V, 0, _V.length);
        _mac.updateByte(0x00);
        _mac.doFinal(_K, 0);

        _mac.init(KeyParameter(_K));
        _mac.update(_V, 0, _V.length);
        _mac.doFinal(_V, 0);
      } else {
        return k;
      }
    }
  }

  BigInt _bitsToInt(Uint8List t) {
    var v = utils.decodeBigIntWithSign(1, t);
    if ((t.length * 8) > _n.bitLength) {
      v = v >> ((t.length * 8) - _n.bitLength);
    }

    return v;
  }

  Uint8List _asUnsignedByteArray(BigInt value) {
    var bytes = utils.encodeBigInt(value);

    if (bytes[0] == 0) {
      return Uint8List.fromList(bytes.sublist(1));
    } else {
      return Uint8List.fromList(bytes);
    }
  }
}
