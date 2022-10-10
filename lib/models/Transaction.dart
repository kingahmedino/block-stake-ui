import 'package:flutter/material.dart';

class Transaction {
  String stakerAdress;
  String amount;
  int block;
  TransactionType type;

  Transaction(this.stakerAdress, this.amount, this.block, this.type);

  Color color() {
    switch (type) {
      case TransactionType.Deposit:
        return Colors.green;
      case TransactionType.ClaimRewards:
        return Colors.blue;
      case TransactionType.Withdrawal:
        return Colors.red[600]!;
      default:
        return Colors.black;
    }
  }
}

enum TransactionType { Deposit, Withdrawal, ClaimRewards }
