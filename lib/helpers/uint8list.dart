import 'dart:typed_data';

Uint8List int4ToUint8List(int value) {
  ByteData byteData = ByteData(4);
  byteData.setInt32(0, value, Endian.little);
  return byteData.buffer.asUint8List();
}
