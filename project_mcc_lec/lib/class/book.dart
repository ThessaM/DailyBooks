class Book{
  late int bookId;
  late String bookTitle;
  late String bookAuthor;
  late int bookPrice;
  late String bookDescription;
  late String bookPath;
  late String backPath;
  late double bookRating;

  Book(int bookId, String bookTitle, String bookAuthor, int bookPrice, String bookDescription, String bookPath, String backPath, double bookRating){
    this.bookId = bookId;
    this.bookTitle = bookTitle;
    this.bookAuthor = bookAuthor;
    this.bookPrice = bookPrice;
    this.bookDescription = bookDescription;
    this.bookPath = bookPath;
    this.backPath = backPath;
    this.bookRating = bookRating;
  }

}