import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/digests/ripemd160.dart';

Uint8List hash256(Uint8List ip) {
  return Uint8List.fromList(sha256.convert(sha256.convert(ip).bytes).bytes);
}

Uint8List hash160(Uint8List ip) {
  Digest digest = sha256.convert(ip);
  var ripHash = RIPEMD160Digest().process(Uint8List.fromList(digest.bytes));
  return ripHash;
}
