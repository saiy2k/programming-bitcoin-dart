class Signature {
  BigInt r;
  BigInt s;

  Signature(this.r, this.s);

  @override
  String toString() {
    return 'Signature(r: $r, s: $s)';
  }
}
