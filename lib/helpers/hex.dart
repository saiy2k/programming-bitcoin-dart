import 'dart:typed_data';

String uint8ListToHex(Uint8List data) {
  return data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}

Uint8List hexStringToBytes(String hex) {
  // Remove any whitespace or common prefixes like "0x"
  String formattedHex = hex.replaceAll(RegExp(r'\s+'), '').replaceAll('0x', '');

  // Ensure the hex string has an even number of characters
  if (formattedHex.length % 2 != 0) {
    throw FormatException('Hexadecimal string must have an even number of characters');
  }

  // Convert the hexadecimal string to bytes
  List<int> bytes = List<int>.generate(formattedHex.length ~/ 2, (index) {
    String byteString = formattedHex.substring(index * 2, index * 2 + 2);
    return int.parse(byteString, radix: 16);
  });

  return Uint8List.fromList(bytes);
}
