class History{
  late final int? id;
  // final int userId;
  // final purchaseDate; //date
  final String bookTitle;
  final int bookPrice;
  final String bookPath;
  final int qty;

  History({
    this.id,
    // required this.userId,
    // required this.purchaseDate,
    required this.bookTitle,
    required this.bookPrice,
    required this.bookPath,
    required this.qty
  });

  factory History.fromMap(Map<dynamic, dynamic> data) => new History(
    id: data['id'], 
    // userId: data['userId'],
    // purchaseDate: data['purchaseDate'],
    bookTitle: data['bookTitle'],
    bookPrice: data['bookPrice'],
    bookPath: data['bookPath'],
    qty: data['qty']
  );


  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      // 'userId': userId,
      // 'purchaseDate': purchaseDate,
      'bookTitle': bookTitle,
      'bookPrice': bookPrice,
      'bookPath' : bookPath,
      'qty': qty
    };
  }

}