class CreditCard {
  final String holderName;
  final String cardNumber;
  final String expiryDate;
  final double balance;
  final List<Transaction> recentTransactions;

  CreditCard({
    required this.holderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.balance,
    required this.recentTransactions,
  });
}

class Transaction {
  final String title;
  final String type;
  final double amount;
  final DateTime date;
  final String? imageUrl;

  Transaction({
    required this.title,
    required this.type,
    required this.amount,
    required this.date,
    this.imageUrl,
  });
}