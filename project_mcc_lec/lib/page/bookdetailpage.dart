// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:project_mcc_lec/cart_screen.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:project_mcc_lec/class/book.dart';
import 'package:project_mcc_lec/class/cart_model.dart';
import 'package:project_mcc_lec/class/cartprovider.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
// import 'package:project_mcc_lec/homepage.dart';
import 'package:project_mcc_lec/class/route.dart';
import 'package:provider/provider.dart';


/*
[v] atur icon favorite -- floating action button
[v] sambungin database - data add to cart
[] sambungin database - favorite, disesuaiin data user
[v] habis add to cart -> lgsg balik ke homepage aja + alert dialog
*/

class BookDetailPage extends StatelessWidget {
  BookDetailPage({super.key, required this.selectedBook});

  DBHelper dbHelper = DBHelper();

  final Book selectedBook;

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartProvider>(context);
    var priceFormat = NumberFormat.simpleCurrency(name: '',);

    void saveData(int index) {
      dbHelper
          .insertCart(
        Cart(
          id: index,
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
          onTap: () => Navigator.pop(context),
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
                Card(
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
                BookDetailSeparator(),
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
                  'Rp.${priceFormat.format(selectedBook.bookPrice)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    // color: Color.fromARGB(255, 92, 92, 92)     
                  ),
                ),
                BookDetailSeparator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rating: ${selectedBook.bookRating}/5',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Icon(Icons.star_rate_rounded, color: Colors.amber,)
                  ],
                ),
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
                Text(
                  'Author',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700      
                  ),
                ),
                Text(
                  '${selectedBook.bookAuthor}',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(223, 255, 255, 255),
                  ),
                  textAlign: TextAlign.justify,
                ),
                BookDetailSeparator(value: 70,),
                // ElevatedButton( // login button
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
      floatingActionButton: Row(
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
          FavoriteButton()
        ],
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
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {

  bool favoriteValue = false;
  Icon favoriteIcon = Icon(Icons.favorite_outline_rounded, size: 36,);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //kurang disambungin sama database
        setState(() {
          if(favoriteValue == false){
          favoriteValue = true;
          favoriteIcon = Icon(Icons.favorite_rounded, size: 36);
        }else{
          favoriteValue = false;
          favoriteIcon = Icon(Icons.favorite_outline_rounded,  size: 36);
        }
        });
      },
      child: Container(
        margin: EdgeInsets.all(15),
        child: favoriteIcon
      ),
    );
  }
}

class AddBookToCartAlertDialog extends StatelessWidget {
  const AddBookToCartAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // insetPadding: EdgeInsets.all(75),
      title: Text("Book added to cart successfully", textAlign: TextAlign.center,),
      titleTextStyle: const TextStyle(
        // color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500
      ),
      content: Text("Tap anywhere outside this box to continue", textAlign: TextAlign.center,),
      contentTextStyle: const TextStyle(
        // color: Colors.grey
        color: Colors.deepOrange
      ),
      // contentPadding: EdgeInsets.fromLTRB(36, 20, 36, 36),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      // alignment: Alignment.center,
    );
  }
}
