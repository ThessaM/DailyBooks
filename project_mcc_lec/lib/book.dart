class Book{
  late String bookTitle;
  late String bookAuthor;
  late String bookPrice;
  late String bookDescription;
  late String bookPath;
  late double bookRating;

  Book(String bookTitle, String bookAuthor, String bookPrice, String bookDescription, String bookPath, double bookRating){
    this.bookTitle = bookTitle;
    this.bookAuthor = bookAuthor;
    this.bookPrice = bookPrice;
    this.bookDescription = bookDescription;
    this.bookPath = bookPath;
    this.bookRating = bookRating;
  }

}