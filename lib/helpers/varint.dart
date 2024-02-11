import 'dart:typed_data';

Uint8List encodeVarint(BigInt no) {
  return Uint8List(0);
}

(BigInt, int) decodeVarint(Uint8List byteStream, int bI) {
  int firstByte = byteStream[bI];

  if (firstByte == 0xfd) {
    return (BigInt.from(byteStream[bI + 1] + (byteStream[bI + 2] << 8)), bI + 3);
  } else if (firstByte == 0xfe) {
    return (
      BigInt.from(byteStream[bI + 1] + (byteStream[bI + 2] << 8) + (byteStream[bI + 3] << 16) + (byteStream[4] << 24)),
      bI + 5
    );
  } else if (firstByte == 0xff) {
    return (
      BigInt.from(byteStream[bI + 1] +
          (byteStream[bI + 2] << 8) +
          (byteStream[bI + 3] << 16) +
          (byteStream[bI + 4] << 24) +
          (byteStream[bI + 5] << 32) +
          (byteStream[bI + 6] << 40) +
          (byteStream[bI + 7] << 48) +
          (byteStream[bI + 8] << 56)),
      bI + 9
    );
  } else {
    return (BigInt.from(firstByte), bI + 1);
  }
}
