// import 'dart:ffi';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_mcc_lec/class/book.dart';
import 'package:project_mcc_lec/class/cart_model.dart';
import 'package:project_mcc_lec/class/cartprovider.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
import 'package:project_mcc_lec/class/favorite_book.dart';
import 'package:project_mcc_lec/page/favoritepage.dart';
import 'package:provider/provider.dart';


/*
[v] atur icon favorite -- floating action button
[v] sambungin database - data add to cart
[v] sambungin database - favorite, disesuaiin data user
[v] habis add to cart -> lgsg balik ke homepage aja + alert dialog
*/

class BookDetailPage extends StatelessWidget {
  BookDetailPage({super.key, required this.selectedBook, 
  required this.currentUserId,
  required this.fromPage,
  this.bookList
  // required this.currentFavoriteState
  // required this.currentFavoriteBook
  });

  DBHelper dbHelper = DBHelper();

  final Book selectedBook;
  final int currentUserId;
  final int fromPage; //1 = homepage, 2 = favoritePage
  List<Book>? bookList = [];
  // FavoriteBook currentFavoriteBook;
  // final bool currentFavoriteState;

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartProvider>(context);
    var priceFormat = NumberFormat.simpleCurrency(name: '',);

    void saveData(int index) {
      dbHelper
          .insertCart(
        Cart(
          id: cart.getUniqueCartId(),
          bookId : index,
          userId: currentUserId,
          bookTitle: selectedBook.bookTitle, 
          bookPrice: selectedBook.bookPrice,
          quantity: ValueNotifier(1), 
          bookPath: selectedBook.bookPath
          // book: product[index]
        )
      )
          .then((value) {
        cart.addTotalPrice(selectedBook.bookPrice.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedBook.bookTitle, overflow: TextOverflow.fade,),
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            if(fromPage == 1) Navigator.pop(context);
            else Navigator.pushAndRemoveUntil(
              context, 
              MaterialPageRoute(builder: (context) => FavoriteBookPage(
                currentUserId: currentUserId, 
                bookList: bookList!)
              ), 
              (route) => false
            );

          },
          // Navigator.push(
          //   context, 
          //   RouterGenerator.generateRoute(RouteSettings(name: '/home'))
          // ),
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 30,),
                FlipCard(
                  // flipOnTouch: false,
                  direction: FlipDirection.HORIZONTAL,
                  side: CardSide.FRONT,
                  front: Card(
                    margin: EdgeInsets.fromLTRB(40, 2, 40, 0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 240,
                        height: 340,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        child: Image(image: AssetImage(selectedBook.bookPath), fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
                      ),      
                    ),
                  ), 
                  back: Card(
                    margin: EdgeInsets.fromLTRB(40, 2, 40, 0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 240,
                        height: 340,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        child: Image(image: AssetImage(selectedBook.backPath), fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
                      ),      
                    ),
                  ),
                ),

                BookDetailSeparator(value: 20,),
                Text(
                  '${selectedBook.bookTitle}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700      
                  ),
                ),
                BookDetailSeparator(),
                Text(
                  '${selectedBook.bookAuthor}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(223, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
                BookDetailSeparator(value: 20,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 73, 73, 73)),
                  height: 100,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Rating"),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${selectedBook.bookRating} / 5',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(Icons.star_rate_rounded, color: Colors.amber,)
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 2,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(223, 255, 255, 255),
                          borderRadius: BorderRadius.circular(50)
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Price"),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Rp.${priceFormat.format(selectedBook.bookPrice)}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              // color: Color.fromARGB(255, 92, 92, 92)     
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Text(
                //   'Rp.${priceFormat.format(selectedBook.bookPrice)}',
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w500,    
                //   ),
                // ),
                // BookDetailSeparator(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Rating: ${selectedBook.bookRating}/5',
                //       style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.w700,
                //       ),
                //     ),
                //     Icon(Icons.star_rate_rounded, color: Colors.amber,)
                //   ],
                // ),
                BookDetailSeparator(value: 20,),
                Text(
                  'Synopsis',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700      
                  ),
                ),
                Text(
                  '${selectedBook.bookDescription}',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(223, 255, 255, 255),
                    wordSpacing: 2     
                  ),
                  textAlign: TextAlign.justify,
                ),
                BookDetailSeparator(),
                BookDetailSeparator(value: 70,),
                // ElevatedButton( 
                //   onPressed: () {
                //     // tambahin ke cart + database                 
                //     // Navigator.push(context, RouterGenerator.generateRoute(
                //     //     RouteSettings(
                //     //       name: '/home',
                //     //     )
                //     //   )
                //     // );
                //     saveData(selectedBook.bookId);
                //     Navigator.pop(context);
                //     showDialog(
                //         context: context, 
                //         builder: (_) => AddBookToCartAlertDialog()
                //     );
                //   }, 
                //   child: Text(
                //     "Add To Cart",
                //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     elevation: 3,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(32)
                //     ),
                //     minimumSize: Size(100, 60)
                //   ), 
                // ),
              ],
            ),
          ),
        )
      ),
      //atur action
      // floatingActionButton: FavoriteButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 100,),
              FloatingActionButton.extended(
                // heroTag: "Test",
                // elevation: 3,
                onPressed: () {
                  saveData(selectedBook.bookId);
                  Navigator.pop(context);
                  showDialog(
                      context: context, 
                      builder: (_) => AddBookToCartAlertDialog()
                  );  
                }, 
                label: Text('Add To Cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              ),
              FavoriteButton(
                bookId: selectedBook.bookId, 
                userId: currentUserId, 
                // currentFavoriteState: currentFavoriteBook, 
              )
            ],
          ),
        ),
        height: 60,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(48, 48, 48, 1),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(48, 48, 48, 1),
              offset: Offset(0, 20),
            ),
            BoxShadow(
              color: Color.fromRGBO(48, 48, 48, 1),
              offset: Offset(0, -10),
              blurRadius: 20,
              spreadRadius: 20
            ),
          ],
        ),
      ),
    );
  }
}


class BookDetailSeparator extends StatelessWidget {
  BookDetailSeparator({super.key, this.value});

  double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value != null? value:10,);
  }
}

class FavoriteButton extends StatefulWidget {
  FavoriteButton({Key? key, required this.bookId, required this.userId, 
  // required this.currentFavoriteState
  }) : super(key: key);

  final int bookId;
  final int userId;
  // bool currentFavoriteState;
  // FavoriteBook currentFavoriteState;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {

  DBHelper dbHelper = DBHelper();

  get bookId => widget.bookId;
  get userId => widget.userId;
  // FavoriteBook get currentFavoriteState => widget.currentFavoriteState;

  // bool favoriteValue = currentFavoriteState;
  // Icon favoriteIcon = Icon(Icons.favorite_outline_rounded, size: 36,);
  // late Icon favoriteIcon;

  List<FavoriteBook> favoriteBookList = [];
  // int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // favoriteValue = currentFavoriteState == 0? false:true;
    return FutureBuilder<FavoriteBook>(
      future: dbHelper.getCurrentFavoriteById(bookId, userId),
      builder: (BuildContext context, AsyncSnapshot<FavoriteBook> snapshot){
        if(!snapshot.hasData){
            return Text("");
          }

        return GestureDetector(
          onTap: () {
            setState(() {
              if(snapshot.data!.favoriteStatus == 0){
                snapshot.data!.favoriteStatus = 1;
                // favoriteIcon = Icon(Icons.favorite_rounded, size: 36);
              }else{
                // favoriteValue = false;
                snapshot.data!.favoriteStatus = 0;
                // favoriteIcon = Icon(Icons.favorite_outline_rounded,  size: 36);
              }
            });

            dbHelper.updateFavoriteStatus(
              FavoriteBook(
                bookId: bookId, 
                userId: userId, 
                // favoriteStatus: favoriteValue? 1:0
                favoriteStatus: snapshot.data!.favoriteStatus
              )
            );

          },
          child: Container(
            margin: EdgeInsets.all(15),
            child: snapshot.data!.favoriteStatus == 0? Icon(Icons.favorite_outline_rounded,  size: 36):Icon(Icons.favorite_rounded, size: 36)
          ),
        );
      }
    );
    
    
    
    // IconButton(
    //   onPressed: () async{
    //     setState(() {
    //       favoriteValue = !favoriteValue;
    //     });

        // dbHelper.updateFavoriteStatus(
        //   FavoriteBook(
        //     bookId: bookId, 
        //     userId: userId, 
        //     favoriteStatus: favoriteValue == true? 1:0
        //   )
        // );
    //   },
    //   icon: favoriteValue? Icon(Icons.favorite_rounded) : Icon(Icons.favorite_border_rounded)
    //   // icon: favoriteIcon,
    // );
  }
}

class AddBookToCartAlertDialog extends StatelessWidget {
  const AddBookToCartAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Book added to cart successfully", textAlign: TextAlign.center,),
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500
      ),
      content: Text("Tap anywhere outside this box to continue", textAlign: TextAlign.center,),
      contentTextStyle: const TextStyle(
        color: Colors.deepOrange
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
    );
  }
}
