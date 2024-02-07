import 'dart:typed_data';
import 'package:crypto/crypto.dart';

Uint8List hash256(Uint8List ip) {
  return Uint8List.fromList(sha256.convert(sha256.convert(ip).bytes).bytes);
}
