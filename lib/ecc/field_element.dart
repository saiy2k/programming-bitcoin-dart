import 'dart:core';

import 'package:dart_bitcoin/ecc/operable.dart';

/**
 * Try making this work with a Generic Type T, where T can be int or BigInt
 */
class FieldElement implements IOperable {
  late BigInt num;
  BigInt prime;

  FieldElement(this.num, this.prime) {
    if (num >= prime || num < BigInt.zero) {
      throw ArgumentError('Num $num is not in field range 0 to ${prime - BigInt.one}');
    }
  }

  FieldElement.fromNegative(BigInt num, this.prime) {
    if (prime <= BigInt.zero) {
      throw ArgumentError("The prime must be positive");
    }

    this.num = ((num % prime) + prime) % prime;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldElement && runtimeType == other.runtimeType && num == other.num && prime == other.prime;

  @override
  FieldElement operator +(FieldElement other) {
    if (prime != other.prime) {
      throw ArgumentError('Cannot add two numbers in different Fields');
    }
    BigInt sum = (num + other.num) % prime;
    return FieldElement(sum, prime);
  }

  @override
  FieldElement operator -(FieldElement other) {
    if (prime != other.prime) {
      throw ArgumentError('Cannot subtract two numbers in different Fields');
    }
    BigInt difference = (num - other.num) % prime;
    return FieldElement(difference, prime);
  }

  @override
  FieldElement operator *(FieldElement other) {
    if (prime != other.prime) {
      throw ArgumentError('Cannot multiply two numbers in different Fields');
    }
    BigInt mul = (num * other.num) % prime;
    return FieldElement(mul, prime);
  }

  @override
  FieldElement operator /(FieldElement other) {
    if (prime != other.prime) {
      throw ArgumentError('Cannot divide two numbers in different Fields');
    }
    BigInt div = (num * other.num.modPow(prime - BigInt.two, prime)) % prime;
    return FieldElement(div, prime);
  }

  @override
  FieldElement pow(BigInt exp) {
    BigInt e = exp % (prime - BigInt.one); // to handle negative numbers and larger than 'prime' exponents
    BigInt res = num.modPow(e, prime);
    return FieldElement(res, prime);
  }

  @override
  FieldElement smul(BigInt exp) {
    BigInt res = num * exp % prime;
    return FieldElement(res, prime);
  }

  @override
  int get hashCode => num.hashCode ^ prime.hashCode;

  @override
  String toString() {
    return 'FieldElement {num: $num, prime: $prime}';
  }
}
