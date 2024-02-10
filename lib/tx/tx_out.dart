class TxOut {
  int amount;
  String script_pubkey;

  TxOut(this.amount, this.script_pubkey) {}

  @override
  String toString() {
    return '$amount:$script_pubkey';
  }
}
