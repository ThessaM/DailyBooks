import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_mcc_lec/class/cart_model.dart';
import 'package:project_mcc_lec/class/cartprovider.dart';
import 'package:project_mcc_lec/class/db_helper.dart';
import 'package:project_mcc_lec/page/paymentpage.dart';
// import 'package:project_mcc_lec/page/tempFolder/temppage.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.currentUserId}) : super(key: key);

  final int? currentUserId;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  DBHelper? dbHelper = DBHelper();
  // List<bool> tapped = [];
  var priceFormat = NumberFormat.simpleCurrency(name: '',);
  get currentUserId => widget.currentUserId;
  // List<Cart> foundCart = [];

  // List<Cart> newCart = [];
  // Future<List<Cart>> getNewCartData() async{
  //   List<Cart> newCartList = await dbHelper!.getCartList();
  //   if(newCartList.isEmpty) return [];
  //   return newCartList;
  // }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<CartProvider>().getData();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<CartProvider>().getData();
      context.read<CartProvider>().getData();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    // final newCart = getNewCartData();

    // void addItemToList(int ind, Cart item){
    //   setState(() {
    //     foundCart.insert(ind, item);
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Shopping Cart'),
        // leading: IconButton(
        //   onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(currentUserId: currentUserId)), (route) => false), 
        //   icon: Icon(Icons.arrow_back_rounded)
        // ),
        actions: [
          Badge(
            badgeColor: Colors.black54,
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter(currentUserId).toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {

                // int countItem = 0;
                // List<Cart> foundCart = [];
                // for(int i = 0; i<provider.cart.length; i++) {
                //   if(provider.cart[i].userId == currentUserId){
                //     // foundCart[countItem] = provider.cart[i];
                //     addItemToList(countItem, provider.cart[i]);
                //     countItem++;
                //   }
                // }

                if (provider.cart.isEmpty) {
                  return const Center(
                      child: Text(
                    'Your Cart is Empty',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ));
                } else {
                  if(cart.getCounter(currentUserId) > 0){
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.cart.length,
                      itemBuilder: (context, index) {
                        if(provider.cart[index].userId == currentUserId){
                          return Card(
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
                                    // constraints: BoxConstraints.expand(),
                                    // clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(provider.cart[index].bookPath!),
                                        fit: BoxFit.cover
                                      ),
                                      // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: Container(
                                      // width: 130,
                                      // constraints: BoxConstraints.expand(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          RichText(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            text: TextSpan(
                                              text: '${provider.cart[index].bookTitle}\n',
                                              style: const TextStyle(
                                                  fontWeight:FontWeight.bold, fontSize: 16
                                              )
                                            )
                                          ),
                                          RichText(
                                            maxLines: 1,
                                            text: TextSpan(
                                              text: "Rp. ",
                                              style: TextStyle(fontSize: 15.0),
                                              children: [
                                                TextSpan(
                                                  text: '${priceFormat.format(provider.cart[index].bookPrice)}\n',
                                                  // text: '${provider.cart[index].bookPrice}\n',
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  )
                                                ),
                                              ]
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //+- button

                                  Row(
                                    children: [
                                      ValueListenableBuilder<int>(
                                        valueListenable: provider.cart[index].quantity!,
                                        builder: (context, val, child) {
                                          return PlusMinusButtons(
                                            addQuantity: () {
                                              cart.addQuantity(provider.cart[index].bookId!, currentUserId);
                                              dbHelper!.updateQuantity(
                                                  Cart(
                                                    id: index,
                                                    bookId: provider.cart[index].bookId,
                                                    userId: currentUserId,
                                                    bookTitle: provider.cart[index].bookTitle,
                                                    bookPrice: provider.cart[index].bookPrice,
                                                    quantity: ValueNotifier(
                                                      provider.cart[index].quantity!.value
                                                    ),
                                                    // quantity: ,
                                                    bookPath: provider.cart[index].bookPath
                                                    // book: provider.cart[index].book
                                                  ),
                                                )
                                                .then((value) {
                                                  setState(() {
                                                    cart.addTotalPrice(double.parse(
                                                      provider.cart[index].bookPrice.toString()
                                                    ));
                                                  });
                                                }
                                              );
                                            },
                                            deleteQuantity: (){
                                              cart.deleteQuantity(provider.cart[index].bookId!, currentUserId);
                                              dbHelper!.updateQuantity(
                                                Cart(
                                                  id: index,
                                                  userId: currentUserId,
                                                  bookId: provider.cart[index].bookId,
                                                  bookTitle: provider.cart[index].bookTitle,
                                                  bookPrice: provider.cart[index].bookPrice,
                                                  quantity: ValueNotifier(
                                                    provider.cart[index].quantity!.value
                                                  ),
                                                  bookPath: provider.cart[index].bookPath
                                                  // book: provider.cart[index].book
                                                ),
                                              ).then((value) {
                                                setState(() {
                                                  cart.removeTotalPrice(double.parse(
                                                    provider.cart[index].bookPrice.toString()
                                                  ));
                                                });
                                              });
                                              // cart.removeTotalPrice(double.parse(
                                              //   provider.cart[index].bookPrice.toString()
                                              // ));
                                            },
                                            // text: val.toString(),
                                            text: provider.cart[index].quantity!.value.toString(),
                                            // text: newCart[index].quantity.toString(),

                                          );
                                      }
                                      ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipOval(child: Container(height: 36, width: 36, color: Colors.red.withOpacity(0.75),)),
                                        IconButton(
                                          onPressed: () {
                                            dbHelper!.deleteCartItem(provider.cart[index].bookId!, currentUserId);
                                            provider.removeItem(provider.cart[index].bookId!, currentUserId);
                                            provider.removeCounter();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Book Removed From Cart', style: TextStyle(color: Colors.deepOrange)),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete_forever_rounded,
                                            // color: Colors.red.shade800,
                                            color: Colors.white,
                                          )
                                        ),
                                      ],
                                    ),
                                      SizedBox(width: 10,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }else{
                          return Container();
                        }
                      },
                      // separatorBuilder: (BuildContext context, int index) => const Divider(height: 5,),
                    );
                  }else{
                    return const Center(
                      child: Text(
                        'Your Cart is Empty',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ));
                  }
                }
              },
            ),
          ),
          Consumer<CartProvider>(
            builder: (BuildContext context, value, Widget? child) {
              final ValueNotifier<int?> totalPrice = ValueNotifier(null);
              for (var element in value.cart) {
                if(element.userId == currentUserId){
                  totalPrice.value =
                    (element.bookPrice! * element.quantity!.value) +
                        (totalPrice.value ?? 0);
                }     
              }
              return Column(
                children: [
                  ValueListenableBuilder<int?>(
                      valueListenable: totalPrice,
                      builder: (context, val, child) {
                        return ReusableWidget(
                            title: 'Sub-Total',
                            // value: r'Rp.' + (val?.toStringAsFixed(2) ?? '0'));
                            value: r'Rp. ' + (val == null? '0' : priceFormat.format(val)));
                      }),
                ],
              );
            },
          )
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Payment Successful'),
          //     duration: Duration(seconds: 2),
          //   ),
          // );
          if(cart.getCounter(currentUserId) == 0){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No Item In Cart', style: TextStyle(color: Colors.deepOrange),),
                duration: Duration(seconds: 1),
              ),
            );
          }else{
            // Navigator.push(context, RouterGenerator.generateRoute(
            //     RouteSettings(
            //       name: '/payment'
            //     )
            //   )
            // );
            // print(cart.quantity);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => PaymentPage(currentUserId: currentUserId))
            );
            // Navigator.push(
            //   context, 
            //   MaterialPageRoute(builder: (context) => TempPage())
            // );
          }
        },
        child: Container(
          color: Colors.deepOrange,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}



class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}