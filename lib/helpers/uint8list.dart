import 'dart:typed_data';

Uint8List intToUint8ListLittle(int value) {
  ByteData byteData = ByteData(4);
  byteData.setInt32(0, value, Endian.little);
  return byteData.buffer.asUint8List();
}

Uint8List intToUint8List(int value, {Endian endian = Endian.big}) {
  ByteData byteData = ByteData(4);
  byteData.setInt32(0, value, endian);
  return byteData.buffer.asUint8List();
}

int uint8ListToInt(Uint8List bytes, {Endian endian = Endian.big}) {
  var byteData = ByteData.sublistView(bytes);
  return byteData.getInt32(0, endian);
}
