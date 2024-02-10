class TxIn {
  String prev_tx;
  int prev_index;
  String script_sig;
  int sequence;

  TxIn(this.prev_tx, this.prev_index, this.script_sig, this.sequence) {}

  @override
  String toString() {
    return '$prev_tx:$prev_index';
  }
}
