// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:project_mcc_lec/class/cart_model.dart';
import 'package:project_mcc_lec/class/cartprovider.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
import 'package:project_mcc_lec/class/route.dart';
import 'package:project_mcc_lec/page/cart_screen.dart';
import 'package:provider/provider.dart';


/*
[v] validasi address
[] update database history
*/


class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  DBHelper dbHelper = DBHelper();
  var priceFormat = NumberFormat.simpleCurrency(name: '',);
  var finalPrice = 0;

  int choosedPayment = 0;

  List<DropdownMenuItem<int>> paymentOption = [
    DropdownMenuItem(child: Text("Gopay"), value: 0,),
    DropdownMenuItem(child: Text("Dana"), value: 1,),
    DropdownMenuItem(child: Text("Ovo"), value: 2,),
    DropdownMenuItem(child: Text("Credit Card"), value: 3,)
  ];

  final addressController = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final del = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Payment'),
        actions: [
          
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              PaymentTitleSection(title: "Delivery Address"),
              SizedBox(height: 10,),
              SizedBox(height: 20,),
              TextFormField( // address,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText: "Input your Address",
                  labelText: "Address",
                  prefixIcon: Icon(Icons.location_on_rounded),
                ),
                controller: addressController,
              ),
              SizedBox(height: 40,),
              PaymentTitleSection(title: "Order Details"),
              SizedBox(height: 10,),
              SeparatorLine(),
              SizedBox(height: 20,),
      
              Table(
                children: [
                  TableRow(
                    children: [
                      Text(
                        "Book Title",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500      
                        ),
                      ),
                      Text(
                        "Qty",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500      
                        ),
                      ),
                      Text(
                        "Price",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500      
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Consumer<CartProvider>(
                builder: (BuildContext context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.getCounter(),
                    itemBuilder: (context, index) => Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      // defaultColumnWidth: FlexColumnWidth(),
                      // columnWidths: const <int, TableColumnWidth>{
                      //   0: FlexColumnWidth(),
                      //   1: FixedColumnWidth(40),
                      //   2: FlexColumnWidth(),
                      // },
                      children: [
                        TableRow(
                          children:  [
                            Text(
                              "${value.cart[index].bookTitle}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300      
                              ),
                            ),
                            Text(
                              "${value.cart[index].quantity!.value}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300      
                              ),
                            ),
                            Text(
                              // "Rp. ${priceFormat.format(value.cart[index].bookPrice)}",
                              "Rp. ${priceFormat.format(value.cart[index].bookPrice! * value.cart[index].quantity!.value)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300      
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  );
                }
              ),
      
              SizedBox(height: 20,),
              SeparatorLine(),
              SizedBox(height: 10,),
      
              Consumer<CartProvider>(
              builder: (BuildContext context, value, Widget? child) {
                final ValueNotifier<int?> totalPrice = ValueNotifier(null);
                  for (var element in value.cart) {
                    totalPrice.value =
                        (element.bookPrice! * element.quantity!.value) +
                            (totalPrice.value ?? 0);
                    finalPrice = totalPrice.value ?? 0;
                  }
      
                  return Column(
                    children: [
                      ValueListenableBuilder<int?>(
                        valueListenable: totalPrice,
                        builder: (context, val, child) {
                          return ViewTotalPrice(
                              title: 'Total',
                              value: r'Rp. ' + (val == null? '0' : priceFormat.format(val)));
                        }
                      ),
                    ],
                  );
                },
              ),
      
              SizedBox(height: 10,),
              SeparatorLine(),
              SizedBox(height: 20,),
              PaymentTitleSection(title: "Payment Method"),
              SizedBox(height: 20,),
              DropdownButtonFormField(
                items: paymentOption,
                value: choosedPayment,
                onChanged: (int? selectedValue) {
                  setState(() {
                    if (selectedValue is int) {
                      choosedPayment = selectedValue;
                    }
                  });
                },
                icon: Icon(Icons.expand_more_rounded),
                // hint: Text("Choose Fish Type Here"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 50,),
              Center(
                child: ElevatedButton( // login button
                  onPressed: (){
                    //validasi address
                    if(validasi(addressController, context)){
                      //tambah update database
                      // cart.removeAllItem();
                      // for(int i = cart.getCounter()-1; i>=0; i--){
                        // dbHelper.deleteCartItem(i);
                        
                        // cart.removeAllItem();
                        // cart.removeCounter();
                      // }
                      // Provider.of<CartProvider>(context).cart.clear();
                      del.clearCart();
                      Navigator.push(context, RouterGenerator.generateRoute(
                        RouteSettings(
                          name: '/home',
                        )
                      ));
                      showDialog(
                          context: context, 
                          builder: (_) => SuccessPaymentAlertDialog()
                      );
                    }  
                  }, 
                  child: Text(
                    "Confirm Payment",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)
                    ),
                    minimumSize: Size(100, 50)
                  ), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PaymentTitleSection extends StatelessWidget {
  const PaymentTitleSection({Key? key, required this.title}) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return Text(
      "  " + title,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700      
      ),
    );
  }
}


class ViewTotalPrice extends StatelessWidget {
  final String title, value;
  const ViewTotalPrice({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500
            ),
          ),
          Text(
            value.toString(),
            // style: Theme.of(context).textTheme.subtitle2,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}


class SeparatorLine extends StatelessWidget {
  const SeparatorLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey.shade300,
    );
  }
}


bool validasi(
    TextEditingController addressController,
    context) {

  if (addressController.text.isEmpty) {
    const snackBar = SnackBar(content: Text("Address must be filled!", style: TextStyle(color: Colors.deepOrange),));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  } 
  return true;
}


class SuccessPaymentAlertDialog extends StatelessWidget {
  const SuccessPaymentAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // insetPadding: EdgeInsets.all(75),
      title: Text("Payment Success", textAlign: TextAlign.center,),
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
