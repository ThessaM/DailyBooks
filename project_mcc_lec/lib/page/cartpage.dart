
// import 'package:flutter/material.dart';

// import 'package:badges/badges.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:project_mcc_lec/page/bookdetailpage.dart';
// import 'package:project_mcc_lec/page/cart_screen.dart';
// import 'package:project_mcc_lec/class/book.dart';
// import 'package:project_mcc_lec/class/cart_model.dart';
// import 'package:project_mcc_lec/class/cartprovider.dart';
// import 'package:project_mcc_lec/class/db_helper.dart';
// import 'package:project_mcc_lec/class/item_model.dart';
// import 'package:project_mcc_lec/page/homepage.dart';
// import 'package:provider/provider.dart';

// import '../class/route.dart';


// class CartPage extends StatefulWidget {
//   const CartPage({Key? key}) : super(key: key);

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Your Cart"),
//         titleSpacing: 0,
//         leading: GestureDetector(
//           onTap: () => Navigator.push(
//             context, 
//             RouterGenerator.generateRoute(RouteSettings(name: '/home'))
//           ),
//           child: Icon(Icons.arrow_back_rounded),
//         ),
//       ),
//       body: Column(
//         children: [
          
//         ],
//       ),
//     );
//   }
// }



// class CartPage extends StatefulWidget {
//   CartPage({super.key, required this.books, required this.bookIndex});

//   late List<Book> books;
//   late int bookIndex;

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {

//   DBHelper dbHelper = DBHelper();
//   List<Book> product = [];
//   late int bookIndex;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     bookIndex = widget.bookIndex;
//     product = widget.books;
//   }
  

//   @override
//   Widget build(BuildContext context) {

//     // product = widget.books;
//     // bookIndex = widget.bookIndex;

//     final cart = Provider.of<CartProvider>(context);
//     void saveData(int index) {
//       dbHelper
//           .insert(
//         Cart(
//           id: index,
//           bookTitle: product[index].bookTitle, 
//           bookPrice: product[index].bookPrice,
//           quantity: ValueNotifier(1), 
//           bookPath: product[index].bookPath
//           // book: product[index]
//         )
//       )
//           .then((value) {
//         cart.addTotalPrice(product[index].bookPrice.toDouble());
//         cart.addCounter();
//         print('Product Added to cart');
//       }).onError((error, stackTrace) {
//         print(error.toString());
//       });
//     }

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Product List'),
//         actions: [
//           Badge(
//             badgeContent: Consumer<CartProvider>(
//               builder: (context, value, child) {
//                 return Text(
//                   value.getCounter().toString(),
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 );
//               },
//             ),
//             position: const BadgePosition(start: 30, bottom: 30),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const HomePage()));
//               },
//               icon: const Icon(Icons.shopping_cart),
//             ),
//           ),
//           const SizedBox(
//             width: 20.0,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(35.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // SizedBox(height: 30,),
//                 Card(
//                   margin: EdgeInsets.fromLTRB(40, 2, 40, 0),
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       width: 240,
//                       height: 340,
//                       padding: EdgeInsets.zero,
//                       alignment: Alignment.center,
//                       child: Image(image: AssetImage(product[bookIndex].bookPath), fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
//                     ),      
//                   ),
//                 ),
//                 BookDetailSeparator(),
//                 Text(
//                   '${product[bookIndex].bookTitle}',
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.fade,
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w700      
//                   ),
//                 ),
//                 BookDetailSeparator(),
//                 Text(
//                   'Rp.${product[bookIndex].bookPrice}',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w500,
//                     color: Color.fromARGB(255, 92, 92, 92)     
//                   ),
//                 ),
//                 BookDetailSeparator(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Rating: ${product[bookIndex].bookRating}/5',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Icon(Icons.star_rate_rounded, color: Colors.amber,)
//                   ],
//                 ),
//                 BookDetailSeparator(value: 20,),
//                 Text(
//                   'Synopsis',
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.fade,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700      
//                   ),
//                 ),
//                 Text(
//                   '${product[bookIndex].bookDescription}',
//                   style: TextStyle(
//                     fontSize: 21,
//                     fontWeight: FontWeight.w500,
//                     color: Color.fromARGB(255, 92, 92, 92)     
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//                 BookDetailSeparator(),
//                 Text(
//                   'Author',
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.fade,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700      
//                   ),
//                 ),
//                 Text(
//                   '${product[bookIndex].bookAuthor}',
//                   style: TextStyle(
//                     fontSize: 21,
//                     fontWeight: FontWeight.w500,
//                     color: Color.fromARGB(255, 92, 92, 92)     
//                   ),
//                   textAlign: TextAlign.justify,
//                 ),
//                 BookDetailSeparator(value: 20,),
//                 ElevatedButton( // login button
//                   onPressed: () {
//                     // tambahin ke cart + database
//                     saveData(bookIndex);                 
//                     // Navigator.push(context, RouterGenerator.generateRoute(
//                     //     RouteSettings(
//                     //       name: '/home',
//                     //     )
//                     //   )
//                     // );
//                     if(mounted){
//                       Navigator.pop(context);
//                     }
                    
//                     showDialog(
//                         context: context, 
//                         builder: (_) => AddBookToCartAlertDialog()
//                     );
//                   }, 
//                   child: Text(
//                     "Add To Cart",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32)
//                     ),
//                     minimumSize: Size(100, 60)
//                   ), 
//                 ),
//               ],
//             ),
//           ),
//         )
//       ),
//       floatingActionButton: IconButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const CartScreen()));
//         },
//         icon: const Icon(Icons.shopping_cart),
//       ),
//     );
//   }
// }

