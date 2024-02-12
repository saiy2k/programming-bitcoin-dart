bool opDup(List<int> stack) {
  if (stack.isEmpty) {
    return false;
  }
  stack.add(stack.last);
  return true;
}
