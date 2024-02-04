import 'dart:typed_data';

import 'package:dart_bitcoin/ecc/s_256_point.dart';

String encodeBase58(Uint8List ip) {
  String BASE58 = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
  int count = 0;
  for (int i = 0; i < ip.length && ip[i] == 0; i++) {
    count++;
  }
  BigInt num = readBytes(ip);

  String result = '';
  while (num > BigInt.zero) {
    BigInt mod = num % BigInt.from(58);
    result = BASE58[mod.toInt()] + result;

    num = num ~/ BigInt.from(58);
  }

  return result;
}
