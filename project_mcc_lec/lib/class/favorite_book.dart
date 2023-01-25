class FavoriteBook{
  final int bookId;
  final int userId;
  int favoriteStatus;


  FavoriteBook({
    required this.bookId,
    required this.userId,
    required this.favoriteStatus,
  });

  void set favoriteBookStatus(int newStatus){
    favoriteStatus = newStatus;
  }

  factory FavoriteBook.fromMap(Map<dynamic, dynamic> data) => new FavoriteBook(
    bookId: data['bookId'], 
    userId: data['userId'],
    favoriteStatus: data['favoriteStatus']
  );


  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId, 
      'userId': userId,
      'favoriteStatus': favoriteStatus
    };
  }

}