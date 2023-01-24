class TransactionHeader{
  late final int? id;
  final int userId;
  final String purchaseDate; //date
  final int totalPrice;
  final int totalItem;

  TransactionHeader({
    this.id,
    required this.userId,
    required this.purchaseDate,
    required this.totalPrice,
    required this.totalItem
  });

  factory TransactionHeader.fromMap(Map<String, dynamic> data) => new TransactionHeader(
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
