import 'dart:typed_data';

String uint8ListToHex(Uint8List data) {
  return data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}
