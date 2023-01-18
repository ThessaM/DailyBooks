// import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_mcc_lec/page/cart_screen.dart';
import 'package:project_mcc_lec/page/cartpage.dart';
import 'package:project_mcc_lec/class/book.dart';
import 'package:project_mcc_lec/page/bookdetailpage.dart';
import 'package:project_mcc_lec/page/loginpage.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:project_mcc_lec/class/route.dart';

/*
[] navigasi drawer -> profile page, history
[] navigasi booklistcard -> ke page detail book
[] navigasi floating action button -> ke cart pages
*/

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? searchedBook;

  final List <Book> books = [
    Book(0, "Crooked House", "Agatha Christie", 60000, "Young Sophia returns after the war to find her grandfather poisoned and a family filled with suspects. Luckily her fiancé, Charles, is the son of the assistant commissioner of Scotland Yard.", "assets/Book/CrookedHouse_AgathaChristie.jpg", 4.5),
    Book(1, "The Case Book of Sherlock Holmes", "Sir Arthur Conan Doyle", 86000, "the final set of twelve Sherlock Holmes short stories", "assets/Book/TheCaseBookOfSherlockHolmes_SirArthur.jpg", 5),
    Book(2, "Sophie's World", "Jostein Gaarder", 72000, "Sophie Amundsen, a Norwegian teenager, who is introduced to the history of philosophy as she is asked, 'Who Are You?'", "assets/Book/DuniaSophie_JosteinGaarder.jpg", 4.5)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: (){
              showSearch(
                context: context, 
                delegate: BookSearchDelegate(books)
              );
            }, 
            icon: Icon(Icons.search_rounded)
          ),
          SizedBox(width: 10,),
          // LogoutButtonAlert()
        ],
        titleSpacing: 0,
      ),
      body: Column(
          children: [
            SizedBox(height: 25,),
            Expanded(child: BookListGridView(bookLists: books))
          ],
        ),
      // body: BookListGridView(bookLists: books),
      drawer: Drawer(
        width: 270,
        child: ListView(
          children: [
            SizedBox(height: 30,),
            DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 75,
                      //bisa diatur lagi sesuai database
                      child: Image(image: AssetImage('assets/Logo/profile_default.jpg'))
                    ),
                  ),
                  SizedBox(width: 10,),
                  //ubah sesuai nama user ${username}
                  Flexible(
                    child: Text("username",
                      style: TextStyle(
                        fontSize: 23
                      ),
                      softWrap: true,
                    ),
                  )
                ],
              )
            ),
            Container(height: 1, color: Colors.grey.shade300,),
            SizedBox(height: 20,),
            HomePageDrawerListTile(
              tileName: "Profile", 
              tileIcon: Icon(Icons.account_circle_rounded, size: 36,), 
              tileRoute: '/'
            ),
            HomePageDrawerListTile(
              tileName: "History", 
              tileIcon: Icon(Icons.article_rounded, size: 36,), 
              tileRoute: '/'
            ),
            SizedBox(
              height: 60,
              child: ListTile(
                textColor: Colors.red.shade700.withOpacity(0.75),
                iconColor: Colors.red.shade700.withOpacity(0.75),
                title: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                leading: Icon(Icons.logout, size: 36,),
                horizontalTitleGap: 15,
                //atur navigasi ke profile page
                onTap: () =>
                  {showDialog(context: context, builder: (_) => LogoutAlert())},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(10),
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen())),
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage(books: books, bookIndex: 0,))),
              //ganti route ke cart page
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ),
      ),
    );
  }
}

class BookSearchDelegate extends SearchDelegate{
  
  BookSearchDelegate(this.books){
    books = this.books;
  }

  List<Book> books; 

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
        Expanded(child: BookListGridView(bookLists: bookFound))
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
  BookListGridView({super.key, required this.bookLists});

  final List <Book> bookLists;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: ScrollController(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          ),
      itemCount: bookLists.length,
      itemBuilder: (context, index) {
        return BookListCard(bookdetail: bookLists[index]);
      });
    
  }
}


class BookListCard extends StatelessWidget {
  const BookListCard({super.key, 
    required this.bookdetail
  });

  final Book bookdetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        //ubah ke detail book page
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetailPage(selectedBook: bookdetail)))
      },
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(height: 10,),
          Card(
            margin: EdgeInsets.fromLTRB(15, 2, 15, 0),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                height: 245,
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                child: Image(image: AssetImage(bookdetail.bookPath), fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
              ),      
            ),
          ),
          SizedBox(height: 5,),
          Text(
            '${bookdetail.bookTitle}',
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700      
            ),
          ),
          SizedBox(height: 5,),
          Text(
            'Rp.${bookdetail.bookPrice}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 92, 92, 92)     
            ),
          ),
          // SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class HomePageDrawerListTile extends StatelessWidget {
  const HomePageDrawerListTile({super.key, required this.tileName, required this.tileIcon, required this.tileRoute});

  final String tileName;
  final Icon tileIcon;
  final String tileRoute;

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
        //atur navigasi ke history page
        onTap: () => Navigator.push(
          context, RouterGenerator.generateRoute(RouteSettings(name: '${tileRoute}'))
        ),
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
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      titlePadding: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 25),
      buttonPadding: EdgeInsets.zero,
      actions: [
        Container(
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(
                      color: Color.fromARGB(136, 216, 216, 216), width: 2))),
          // width: double.infinity,
          child: CupertinoDialogAction(
            child: Text('Logout'),
            textStyle:
                TextStyle(color: Colors.red[600], fontWeight: FontWeight.w600),
            onPressed: () => {
              Navigator.pushAndRemoveUntil(
                  context,
                  // ku ganti ke login page yaa
                  //okee
                  RouterGenerator.generateRoute(RouteSettings(name: '/')),
                  (route) => false)
            },
          ),
        ),
        CupertinoDialogAction(
          child: Text('Cancel'),
          textStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      elevation: 24,
      backgroundColor: Color.fromARGB(240, 255, 255, 255),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}









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