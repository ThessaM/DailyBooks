import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
import 'package:project_mcc_lec/class/history.dart';
import 'package:project_mcc_lec/class/transaction.dart';
import 'package:project_mcc_lec/page/paymentpage.dart';


/*
[] connect ke database
*/


class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.currentUserId}) : super(key: key);

  final int currentUserId;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  DBHelper dbHelper = DBHelper();
  var priceFormat = NumberFormat.simpleCurrency(name: '',);
  int currentUserTransactionCount = 0;

  get currentUserId => widget.currentUserId;

  @override
  Widget build(BuildContext context) {

    // Future<int> fetchCurrentUserTransactionCount = dbHelper.getAmountTransactionHeaderById(currentUserId);
    // fetchCurrentUserTransactionCount() async {
    //   int res = await dbHelper.getAmountTransactionHeaderById(currentUserId);
    //   setState(() {
    //     currentUserTransactionCount = res;
    //   });
    // };

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your History'),
      ),
      body: FutureBuilder<List<TransactionHeader>>(
        future: dbHelper.getTransactionHeader(),
        // shrinkWrap: true,
        builder: (BuildContext context, AsyncSnapshot<List<TransactionHeader>> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Text(
                "No Transaction Found", 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 18.0
                ),
              )
            );
          }else{
            if(snapshot.data!.any((element) => element.userId == currentUserId) == false){
              return Center(
                child: Text(
                  "No Transaction Found", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 18.0
                  ),
                )
              );
            }
            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.map((transactionList) {
                if(transactionList.userId == currentUserId){
                  return Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Id: ${transactionList.id}', 
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              Text(
                                transactionList.purchaseDate, 
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              // Text(
                              //   'Rp. ${priceFormat.format(transactionList[index].totalPrice)}', 
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.w700
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          SeparatorLine(),
                          SizedBox(height: 5,),
                          Container(
                            height: transactionList.totalItem * 65,
                            // height: 40,
                            child: FutureBuilder<List<History>>(
                              future: dbHelper.getHistory(),
                              builder: (BuildContext context, AsyncSnapshot<List<History>> snapshot){
                                if(!snapshot.hasData){
                                  return Text("");
                                }
                                return ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: snapshot.data!.map((historyList) {
                                    if(historyList.id == transactionList.id){
                                      return Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              height: 55,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(historyList.bookPath),
                                                  fit: BoxFit.cover
                                                ),
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                            ),
                                            // SizedBox(width: 10,),
                                            Flexible(
                                              child: Text(
                                                historyList.bookTitle,
                                                style:  TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400
                                                ),
                                                overflow: TextOverflow.fade,
                                                softWrap: true,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            
                                            Text(
                                              '${historyList.qty} x Rp. ${priceFormat.format(historyList.bookPrice)}',
                                              // '${historyList[historyIndex].qty}       ',
                                              style:  TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400
                                              ),
                                            )
                                          ]
                                        ),
                                      );
                                    }else{
                                      // print('NotFound');
                                      return SizedBox.shrink();
                                      // return Container();
                                    }
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10,),
                          SeparatorLine(),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Text(
                                'Rp. ${priceFormat.format(transactionList.totalPrice)}', 
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ],
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


// class _HistoryPageState extends State<HistoryPage> {

//   var priceFormat = NumberFormat.simpleCurrency(name: '',);

//   get currentUserId => widget.currentUserId;

//   List<TransactionHeader> transactionList = [
//     TransactionHeader(id: 0, userId: 1, purchaseDate: '22-2-2019', totalPrice: 240000, totalItem: 3),
//     TransactionHeader(id: 1, userId: 1, purchaseDate: '10-2-2019', totalPrice: 70000, totalItem: 1),
//     TransactionHeader(id: 2, userId: 0, purchaseDate: '18-2-2019', totalPrice: 120000, totalItem: 2),
//   ];

//   List<History> historyList = [
//     History(id: 0, bookTitle: "Crooked House", bookPrice: 50000, bookPath: 'assets/Book/CrookedHouse_AgathaChristie.jpg', qty: 2),
//     History(id: 0, bookTitle: "Sophie's World", bookPrice: 70000, bookPath: 'assets/Book/DuniaSophie_JosteinGaarder.jpg', qty: 1),
//     History(id: 0, bookTitle: "The Case Book of Sherlock Holmes", bookPrice: 70000, bookPath: 'assets/Book/TheCaseBookOfSherlockHolmes_SirArthur.jpg', qty: 1),
//     History(id: 1, bookTitle: "Sophie's World", bookPrice: 70000,bookPath: 'assets/Book/DuniaSophie_JosteinGaarder.jpg', qty: 1),
//     History(id: 2, bookTitle: "Crooked House", bookPrice: 50000, bookPath: 'assets/Book/CrookedHouse_AgathaChristie.jpg', qty: 2),
//     History(id: 2, bookTitle: "Sophie's World", bookPrice: 70000, bookPath: 'assets/Book/DuniaSophie_JosteinGaarder.jpg', qty: 1),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Your History'),
//       ),
//       body: ListView.builder(
//         shrinkWrap: true,
//         itemCount: transactionList.length,
//         itemBuilder: (context, index){

//           if(transactionList[index].userId == currentUserId){
//             return Card(
//               margin: EdgeInsets.all(10),
//               elevation: 5,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Id: ${transactionList[index].id}', 
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700
//                           ),
//                         ),
//                         Text(
//                           transactionList[index].purchaseDate, 
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700
//                           ),
//                         ),
//                         // Text(
//                         //   'Rp. ${priceFormat.format(transactionList[index].totalPrice)}', 
//                         //   style: TextStyle(
//                         //     fontSize: 18,
//                         //     fontWeight: FontWeight.w700
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                     SizedBox(height: 5,),
//                     SeparatorLine(),
//                     SizedBox(height: 5,),
//                     Container(
//                       height: transactionList[index].totalItem * 65,
//                       // height: 40,
//                       child: ListView.builder(
//                         // controller: ScrollController(),
//                         // physics: ClampingScrollPhysics(),
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: historyList.length,
//                         itemBuilder: (context, historyIndex){
//                           if(historyList[historyIndex].id == transactionList[index].id){
//                             return Padding(
//                               padding: const EdgeInsets.all(5),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Container(
//                                     height: 55,
//                                     width: 35,
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage(historyList[historyIndex].bookPath),
//                                         fit: BoxFit.cover
//                                       ),
//                                       borderRadius: BorderRadius.circular(5)
//                                     ),
//                                   ),
//                                   // SizedBox(width: 10,),
//                                   Flexible(
//                                     child: Text(
//                                       historyList[historyIndex].bookTitle,
//                                       style:  TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w400
//                                       ),
//                                       overflow: TextOverflow.fade,
//                                       softWrap: true,
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
                                  
//                                   Text(
//                                     '${historyList[historyIndex].qty} x Rp. ${priceFormat.format(historyList[historyIndex].bookPrice)}',
//                                     // '${historyList[historyIndex].qty}       ',
//                                     style:  TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w400
//                                     ),
//                                   )
//                                 ]
//                               ),
//                             );
//                           }else{
//                             // print('NotFound');
//                             return SizedBox.shrink();
//                             // return Container();
//                           }
//                         }
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//                     SeparatorLine(),
//                     SizedBox(height: 10,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(),
//                         Text(
//                           'Rp. ${priceFormat.format(transactionList[index].totalPrice)}', 
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }else{
//             return SizedBox.shrink();
//           }

//         }
//       ),
//     );
//   }
// }