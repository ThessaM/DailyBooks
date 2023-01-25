
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
import 'package:project_mcc_lec/class/favorite_book.dart';
import 'package:project_mcc_lec/class/user.dart';
import 'package:project_mcc_lec/page/cart_screen.dart';
import 'package:project_mcc_lec/class/book.dart';
import 'package:project_mcc_lec/page/bookdetailpage.dart';
import 'package:project_mcc_lec/page/historypage.dart';
import 'package:project_mcc_lec/class/route.dart';
import 'package:project_mcc_lec/page/profilepage.dart';


/*
[v] ambil database -> -> drawer -> profile image
[v] ambil database -> drawer -> username
[v] navigasi drawer -> profile page
[v] navigasi drawer -> history
[v] navigasi booklistcard -> ke page detail book
[v] navigasi floating action button -> ke cart pages
*/

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.currentUserId}) : super(key: key);

  final int? currentUserId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DBHelper dbHelper = DBHelper();
  String? searchedBook;
  get currentUserId => widget.currentUserId;
  int quoteIndex = Random().nextInt(7);
  // User? currentUserData;

  final List <Book> books = [
    Book(
      0, 
      "Crooked House", 
      "Agatha Christie", 
      185000, 
      "Young Sophia returns after the war to find her grandfather poisoned and a family filled with suspects. Luckily her fiancé, Charles, is the son of the assistant commissioner of Scotland Yard.", 
      "assets/Book/CrookedHouse_AgathaChristie.jpg",
      "assets/Book/CrookedHouse_back.jpeg",
      256,
      4.6,
      "#46,149"
    ),
    Book(
      1, 
      "The Case Book of Sherlock Holmes", 
      "Sir Arthur Conan Doyle", 
      67000, 
      "the final set of twelve Sherlock Holmes short stories", 
      "assets/Book/TheCaseBookOfSherlockHolmes_SirArthur.jpg",
      "assets/Book/TheCaseBookOfSherlockHolmes_back.jpg",
      303,
      4.1,
      "#109,212"
    ),
    Book(
      2, 
      "Sophie's World", 
      "Jostein Gaarder", 
      157000, 
      "Sophie Amundsen, a Norwegian teenager, who is introduced to the history of philosophy as she is asked, 'Who Are You?'", 
      "assets/Book/DuniaSophie_JosteinGaarder.jpg", 
      "assets/Book/DuniaSophie_back.jpg",
      544,
      4.5,
      "#6,989"
    ),
    Book(
      3, 
      "The Alchemist", 
      "Paulo Coelho", 
      184000, 
      "Paulo Coelho's masterpiece tells the magical story of Santiago, an Andalusian shepherd boy who yearns to travel in search of a worldly treasure as extravagant as any ever found. The story of the treasures Santiago finds along the way teaches us, as only a few stories can, about the essential wisdom of listening to our hearts, learning to read the omens strewn along life's path, and, above all, following our dreams.", 
      "assets/Book/TheAlchemist_PauloCoelho.jpg", 
      "assets/Book/TheAlchemist_back.jpg",
      208,
      4.7,
      "#53"
    ),
    Book(
      4, 
      "Dear Evan Hansen", 
      "Val Emmich, Steven Levenson, Benj Pasek, Justin Paul", 
      181000, 
      "'Dear Evan Hansen, Today's going to be an amazing day and here's why...' A simple lie leads to complicated truths in this big-hearted coming-of-age story of grief, authenticity, and the struggle to belong in an age of instant connectivity and profound isolation.", 
      "assets/Book/DearEvanHansen_ValEmmich.jpg", 
      "assets/Book/DearEvanHansen_back.jpg",
      368,
      4.7,
      "#80,995"
    ),
    Book(
      5, 
      "Five Feet Apart", 
      "Rachael Lippincott, Mikki Daughtry, Tobias Laconis", 
      135000, 
      "'Can you love someone you can never touch?' Stella Grant likes to be in control—even though her totally out of control lungs have sent her in and out of the hospital most of her life. At this point, what Stella needs to control most is keeping herself away from anyone or anything that might pass along an infection and jeopardize the possibility of a lung transplant. Six feet apart. No exceptions.", 
      "assets/Book/FiveFeetApart_RachaelLippincott.jpg", 
      "assets/Book/FiveFeetApart_back.jpg",
      304,
      4.8,
      "#9,155"
    )
  ];

  final List<String> quotes = [
    "“Books are a uniquely portable magic.”\n―Stephen King",
    "“I love the way that each book — any book — is its own journey. You open it, and off you go…”\n-Sharon Creech",
    "“A great book should leave you with many experiences, and slightly exhausted at the end. You live several lives while reading.”\n-William Styron",
    "“That’s the thing about books. They let you travel without moving your feet.”\n-Jhumpa Lahiri in The Namesake",
    "“A reader lives a thousand lives before he dies.” \n-George R. R. Martin",
    "“Come to a book as you would come to an unexplored land. Come without a map. Explore it, and draw your own map.”\n-Stephen King",
    "“A truly good book is something as natural, and as unexpectedly and unaccountably fair and perfect, as a wild flower discovered on the prairies of the West or in the jungles of the East.”\n-Henry David Thoreau"
  ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // context.read<CartProvider>().getData();
  // }

  @override
  Widget build(BuildContext context) {
    // Future<User> fetchCurrentUserData = dbHelper.getCurrentUserById(currentUserId);

    // fetchCurrentUserData.then((data) {
    //   setState(() {
    //     currentUserData = data;
    //   });
    // }, onError: (e) {
    //     print(e);
    // });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: (){
              showSearch(
                context: context, 
                delegate: BookSearchDelegate(books, currentUserId)
              );
            }, 
            icon: Icon(Icons.search_rounded)
          ),
          SizedBox(width: 10,),
          // LogoutButtonAlert()
        ],
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Hello, Welcome!!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23
                  ),
                ),
              ),
              // SeparatorLine(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                child: Card(
                  // color: Colors.deepOrange.shade400,
                  // shadowColor: Colors.deepOrange.shade600,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 15),
                  child: ClipRRect(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            // Color.fromARGB(255, 241, 39, 17),
                            // Color.fromARGB(255, 245, 175, 25)
                             Color.fromARGB(255, 255, 81, 47),
                            Color.fromARGB(255, 240, 152, 25)
                          ]
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          quotes[quoteIndex],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "All Books",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23
                  ),
                ),
              ),
              SizedBox(height: 5,),
              // Expanded(child: BookListGridView(bookLists: books, currentUserId: currentUserId,))
              Flexible(
                // flex: FlexFit.loose,
                child: BookListGridView(
                  bookLists: books, 
                  currentUserId: currentUserId,
                  choosedScrollPhysics: NeverScrollableScrollPhysics(),
                )
              )
            ],
          ),
      ),
      drawer: Drawer(
        width: 270,
        child: 
        ListView(
          children: [
            SizedBox(height: 30,),
            FutureBuilder<User>(
              future: dbHelper.getCurrentUserById(currentUserId),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot){
                if(snapshot.hasData){
                  return DrawerHeader(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 75,
                          decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(20),
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            // image: pickedGalleryImage == null
                            image: snapshot.data!.profileImage == '0'
                                ? DecorationImage(
                                    image: AssetImage('assets/Logo/profile_default.jpg'))
                                : DecorationImage(
                                    // image: FileImage(pickedGalleryImage!),
                                    image: FileImage(File(snapshot.data!.profileImage!)),
                                    fit: BoxFit.cover)
                            ),
                          // child: snapshot.data!.profileImage == '0'?
                          // Image(image: AssetImage('assets/Logo/profile_default.jpg'))
                          // : Image.file(File(snapshot.data!.profileImage!))
                        ),                      
                        SizedBox(width: 10,),
                        Flexible(
                          child: Text(
                            // "username",
                            snapshot.data!.username,
                            style: TextStyle(
                              fontSize: 23
                            ),
                            softWrap: true,
                          ),
                        )
                      ],
                    )
                  );
                }
                return Text("");
              }
            ),
            Container(height: 1, color: Colors.grey.shade300,),
            SizedBox(height: 20,),
            HomePageDrawerListTile(
              tileName: "Profile", 
              tileIcon: Icon(Icons.account_circle_rounded, size: 36,), 
              tileRoute: ProfilePage(currentUserId: currentUserId)
            ),
            HomePageDrawerListTile(
              tileName: "History", 
              tileIcon: Icon(Icons.article_rounded, size: 36,), 
              tileRoute: HistoryPage(currentUserId: currentUserId)
              // tileRoute: TempPage(),
            ),
            SizedBox(
              height: 60,
              child: ListTile(
                // textColor: Colors.red.shade700,
                // iconColor: Colors.red.shade700,
                textColor: Colors.deepOrange,
                iconColor: Colors.deepOrange,
                title: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                leading: Icon(Icons.logout, size: 36,),
                horizontalTitleGap: 15,
                onTap: () =>
                  {showDialog(context: context, builder: (_) => LogoutAlert())},
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(10),
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage(currentUserId: currentUserId,))),
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ),
      ),
    );
  }
}

class BookSearchDelegate extends SearchDelegate{
  
  BookSearchDelegate(this.books, this.currentUserId){
    books = this.books;
    currentUserId = this.currentUserId;
  }

  List<Book> books;
  int currentUserId; 

  List<String> searchResults = [
      "Crooked House",
      "Sophie's World",
    ];

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Search Book Title...";

  @override
  Widget? buildLeading(BuildContext context) => IconButton( 
    icon: Icon(Icons.arrow_back_rounded),
    onPressed: () => close(context, null),
  );

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      // padding: EdgeInsets.only(right: 15),
      icon: Icon(Icons.clear_rounded),
      onPressed: (){
        if(query.isEmpty){
          close(context, null);
        }else{
          query = '';
        }
      }, 
    )
  ];

  @override
  Widget buildResults(BuildContext context) {
    List <Book> bookFound = books.where((books) {
      final book = books.bookTitle.toLowerCase();
      final input = query.toLowerCase();
      return book.contains(input);
    }).toList();

    return Column(
      children: [
        SizedBox(height: 35,),
        Expanded(
          child: BookListGridView(
            bookLists: bookFound, 
            currentUserId: currentUserId,
            choosedScrollPhysics: ScrollPhysics(),
          )
        )
      ],
    );

  }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResults) {
      final result = searchResults.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: (){
            query = suggestion;
            showResults(context);
          },
        );
      }
    );
  }
}


class BookListGridView extends StatelessWidget {
  BookListGridView({super.key, required this.bookLists, required this.currentUserId, required this.choosedScrollPhysics});

  final List <Book> bookLists;
  final int currentUserId;
  ScrollPhysics choosedScrollPhysics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // controller: ScrollController(),
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      physics: choosedScrollPhysics,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          // childAspectRatio: 1,
          ),
      itemCount: bookLists.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(3),
          child: BookListCard(
            bookdetail: bookLists[index],
            currentUserId: currentUserId,
          ),
        );
      });
    
  }
}


class BookListCard extends StatefulWidget {
  const BookListCard({super.key, 
    required this.bookdetail,
    required this.currentUserId
  });

  final Book bookdetail;
  final int currentUserId;

  @override
  State<BookListCard> createState() => _BookListCardState();
}

class _BookListCardState extends State<BookListCard> {

  DBHelper dbHelper = DBHelper();

  Book get bookDetail => widget.bookdetail;
  get currentUserId => widget.currentUserId;

  int index = -1;

  @override
  Widget build(BuildContext context) {
    var priceFormat = NumberFormat.simpleCurrency(name: '',);
    return GestureDetector(
      onTap: () async {

        List<FavoriteBook> favoriteBookList = await dbHelper.getFavorite();
        bool statusRes = false;
        index = favoriteBookList.indexWhere((element) => element.bookId == bookDetail.bookId && element.userId == currentUserId);
        print(index);
        if(index == -1){
          dbHelper.addFavorite(FavoriteBook(
            bookId: bookDetail.bookId, 
            userId: currentUserId, 
            favoriteStatus: 0
          ));
        }
        // else{
        //   if(favoriteBookList[index].favoriteStatus == 1){
        //     statusRes = true;
        //   }
        // }

        Navigator.push(context, MaterialPageRoute(
          builder: (context) => BookDetailPage(
            selectedBook: bookDetail,
            currentUserId: currentUserId,
            // currentFavoriteState: statusRes,
            // currentFavoriteBook: FavoriteBook(
            //   bookId: bookDetail.bookId, 
            //   userId: currentUserId, 
            //   favoriteStatus: statusRes?1:0
            // ),
          )
        ));
      },
      child: Card(
        elevation: 5,
        color: Color.fromARGB(255, 56, 56, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 8,),
            Card(
              margin: EdgeInsets.fromLTRB(15, 2, 15, 0),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height/4.1,
                  // width: 125,
                  // height: 200,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  child: Image(image: AssetImage(widget.bookdetail.bookPath), fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
                ),      
              ),
            ),
            SizedBox(height: 7,),
            Text(
              '${widget.bookdetail.bookTitle}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700      
              ),
            ),
            SizedBox(height: 5,),
            Text(
              'Rp.${priceFormat.format(widget.bookdetail.bookPrice)}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(223, 255, 255, 255),
              ),
            ),
            // SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

class HomePageDrawerListTile extends StatelessWidget {
  const HomePageDrawerListTile({super.key, required this.tileName, required this.tileIcon, required this.tileRoute});

  final String tileName;
  final Icon tileIcon;
  final Widget tileRoute;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListTile(
        title: Text(
          tileName,
          style: TextStyle(
            fontSize: 18
          ),
        ),
        leading: tileIcon,
        horizontalTitleGap: 15,
        // onTap: () => Navigator.push(
        //   context, 
        //   // RouterGenerator.generateRoute(RouteSettings(name: '${tileRoute}'))
        //   MaterialPageRoute(builder: (context) => tileRoute)
        // ),
        onTap: () => Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(builder: (context) => tileRoute), 
          (route) => false),
      ),
    );
  }
}


class LogoutAlert extends StatelessWidget {
  const LogoutAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Logout of your account?',
        textAlign: TextAlign.center,
      ),
      titleTextStyle: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold),
      titlePadding: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 25),
      buttonPadding: EdgeInsets.zero,
      actions: [
        Container(
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(
                      color: Color.fromARGB(133, 48, 48, 48), width: 2))),
          // width: double.infinity,
          child: CupertinoDialogAction(
            child: Text('Logout'),
            textStyle:
                TextStyle(color: Colors.red[600], fontWeight: FontWeight.w600),
            onPressed: () => {
              Navigator.pushAndRemoveUntil(
                  context,
                  RouterGenerator.generateRoute(RouteSettings(name: '/')),
                  (route) => false)
            },
          ),
        ),
        CupertinoDialogAction(
          child: Text('Cancel'),
          textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      elevation: 24,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}



// class LineDashedPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()..strokeWidth = 2;
//     var max = 50;
//     var dashWidth = 5;
//     var dashSpace = 5;
//     double startY = 0;
//     while (max >= 0) {
//       canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
//       final space = (dashSpace + dashWidth);
//       startY += space;
//       max -= space;
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }



// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   Icon searchIcon = const Icon(Icons.search_rounded);
//   Widget searchBar = const Text("Search book");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: searchBar,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 if(searchIcon.icon == Icons.search_rounded){
//                   searchIcon = Icon(Icons.cancel_rounded);
//                   searchBar = const ListTile(
//                     leading: Icon(Icons.search_rounded, color: Colors.white, size: 28,),
//                     title: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Type in book title...',
//                         hintStyle: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontStyle: FontStyle.italic
//                         ),
//                         border: InputBorder.none,
//                       ),
//                       style: TextStyle(
//                         color: Colors.white
//                       ),
//                     ),
//                   );
//                 }
//                 else{
//                   searchIcon = Icon(Icons.search_rounded);
//                   searchBar = Text("Search book");
//                 }
//               });
//             }, 
//             icon: searchIcon
//           ),
//           LogoutButtonAlert()
//         ],
//         leading: Icon(Icons.menu_rounded),
//         titleSpacing: 0,
//       ),
//     );
//   }
// }