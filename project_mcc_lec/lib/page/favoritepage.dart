import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:project_mcc_lec/class/book.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
import 'package:project_mcc_lec/class/favorite_book.dart';
import 'package:project_mcc_lec/page/bookdetailpage.dart';
// import 'package:project_mcc_lec/class/user.dart';
// import 'package:project_mcc_lec/page/bookdetailpage.dart';
import 'package:project_mcc_lec/page/homepage.dart';
import 'package:project_mcc_lec/page/loginpage.dart';

class FavoriteBookPage extends StatefulWidget {
  const FavoriteBookPage({Key? key, required this.currentUserId, required this.bookList}) : super(key: key);

  final int currentUserId;
  final List<Book> bookList;

  @override
  State<FavoriteBookPage> createState() => _FavoriteBookPageState();
}

class _FavoriteBookPageState extends State<FavoriteBookPage> {

  DBHelper dbHelper = DBHelper();
  get currentUserId => widget.currentUserId;
  List<Book> get bookList => widget.bookList;
  int favoriteCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favorite'),
        leading: IconButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (context) => HomePage(currentUserId: currentUserId)), 
            (route) => false
          ) , 
          icon: Icon(Icons.arrow_back_rounded)
        ),
      ),
      body: FutureBuilder<List<FavoriteBook>>(
        future: dbHelper.getFavorite(),
        // shrinkWrap: true,
        builder: (BuildContext context, AsyncSnapshot<List<FavoriteBook>> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Text(
                "No Favorite Book Found", 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 18.0
                ),
              )
            );
          }else{
            if(snapshot.data!.any((element) => element.userId == currentUserId ) == false){
              return Center(
                child: Text(
                  "No Favorite Book Found", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 18.0
                  ),
                )
              );
            }
            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.map((favoriteList) {
                if(favoriteList.userId == currentUserId && favoriteList.favoriteStatus == 1){
                  return GestureDetector(
                    onTap: () => 
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(
                          selectedBook: bookList[favoriteList.bookId], 
                          currentUserId: currentUserId,
                          fromPage: 2,
                          bookList: bookList,
                        ),
                        // maintainState: false
                      ), 
                      (route) => true
                    ),
                    child: Card(
                      color: Color.fromARGB(255, 73, 73, 73),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: 120,
                              width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(bookList[favoriteList.bookId].bookPath),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            SizedBox(width: 5,),
                  
                            Flexible(
                              child: Text(
                                '${bookList[favoriteList.bookId].bookTitle}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                  
                            SizedBox(width: 5,),
                  
                            // FavoriteButton(
                            //   bookId: favoriteList.bookId, 
                            //   userId: currentUserId
                            // )
                  
                            FutureBuilder<FavoriteBook>(
                              future: dbHelper.getCurrentFavoriteById(favoriteList.bookId, currentUserId),
                              builder: (BuildContext context, AsyncSnapshot<FavoriteBook> snapshot){
                                if(!snapshot.hasData){
                                    return Text("");
                                  }
                  
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      snapshot.data!.favoriteStatus = 0;
                                      // if(snapshot.data!.favoriteStatus == 0){
                                      //   snapshot.data!.favoriteStatus = 1;
                                      //   // favoriteIcon = Icon(Icons.favorite_rounded, size: 36);
                                      // }else{
                                      //   // favoriteValue = false;
                                      //   snapshot.data!.favoriteStatus = 0;
                                      //   // favoriteIcon = Icon(Icons.favorite_outline_rounded,  size: 36);
                                      // }
                                    });
                  
                                    dbHelper.updateFavoriteStatus(
                                      FavoriteBook(
                                        bookId: favoriteList.bookId, 
                                        userId: currentUserId, 
                                        // favoriteStatus: favoriteValue? 1:0
                                        favoriteStatus: snapshot.data!.favoriteStatus
                                      )
                                    );
                  
                                    bookFavoriteRemovedSnackbar(context);
                  
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    child: snapshot.data!.favoriteStatus == 0? Icon(Icons.favorite_outline_rounded,  size: 36):Icon(Icons.favorite_rounded, size: 36)
                                  ),
                                );
                              }
                            )
                                                                                                                              
                          ],
                        ),
                      ),
                    ),
                  );
                }else{
                  return SizedBox.shrink();
                }
            }).toList(),
          );
          }
        }
      ),
    );
  }
}


void bookFavoriteRemovedSnackbar(context){
  const snackbar = SnackBar(
    content: DefaultSnackBar(title: "Book removed from favorite"), 
    duration: Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}