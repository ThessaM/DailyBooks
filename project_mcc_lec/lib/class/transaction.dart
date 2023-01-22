class Transaction{
  late final int? id;
  final int userId;
  final purchaseDate; //date
  final int totalPrice;
  final int totalItem;

  Transaction({
    this.id,
    required this.userId,
    required this.purchaseDate,
    required this.totalPrice,
    required this.totalItem
  });

  factory Transaction.fromMap(Map<dynamic, dynamic> data) => new Transaction(
    id: data['id'], 
    userId: data['userId'],
    purchaseDate: data['purchaseDate'],
    totalPrice: data['totalPrice'],
    totalItem: data['totalItem']
  );


  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'userId': userId,
      'purchaseDate': purchaseDate,
      'totalPrice' : totalPrice,
      'totalItem' : totalItem
    };
  }
}
