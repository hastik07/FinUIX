import 'package:flutter/foundation.dart';

import '../models/card_model.dart';

class CardViewModel extends ChangeNotifier {
  late CreditCard _card;
  List<Transaction> _monthlyTransactions = [];
  double _monthlyEarnings = 0.0;

  CreditCard get card => _card;
  List<Transaction> get monthlyTransactions => _monthlyTransactions;
  double get monthlyEarnings => _monthlyEarnings;

  CardViewModel() {
    // Initialize with dummy data
    _card = CreditCard(
      holderName: 'Hastik Mangukiya',
      cardNumber: '2781 8191 6671 3190',
      expiryDate: '09/29',
      balance: 7008.14,
      recentTransactions: [
        Transaction(
          title: 'Monthly Salary',
          type: 'income',
          amount: 4000.00,
          date: DateTime.now(),
          imageUrl: 'assets/images/salary.svg',
        ),
        Transaction(
          title: 'Stock Dividends',
          type: 'investment_income',
          amount: 150.00,
          date: DateTime.now().subtract(const Duration(days: 2)),
          imageUrl: 'assets/images/stocks.svg',
        ),
      ],
    );

    _calculateMonthlyEarnings();
  }

  void _calculateMonthlyEarnings() {
    final now = DateTime.now();
    _monthlyTransactions = _card.recentTransactions
        .where((t) =>
            t.date.month == now.month &&
            t.date.year == now.year &&
            t.type.contains('income'))
        .toList();

    _monthlyEarnings = _monthlyTransactions.fold(
        0, (sum, transaction) => sum + transaction.amount);

    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    _card.recentTransactions.insert(0, transaction);
    _calculateMonthlyEarnings();
  }
}
