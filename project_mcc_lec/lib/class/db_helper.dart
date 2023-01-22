import 'package:project_mcc_lec/class/cart_model.dart';
import 'package:project_mcc_lec/class/history.dart';
import 'package:project_mcc_lec/class/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;


class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'shop.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'DROP TABLE IF EXISTS cart'
    );
    await db.execute(
      'DROP TABLE IF EXISTS user'
    );
    await db.execute(
        'CREATE TABLE cart(id INTEGER, bookId INTEGER, userId INTEGER, bookTitle VARCHAR, bookPrice INTEGER, quantity INTEGER, bookPath TEXT, PRIMARY KEY(bookId, UserId))'
      );
    await db.execute(
        'CREATE TABLE user( id INTEGER PRIMARY KEY, username VARCHAR, email TEXT, phoneNumber TEXT, password TEXT, profileImage TEXT)'
      );
    // await db.execute(
    //     'CREATE TABLE history(id INTEGER , bookTitle TEXT, bookPrice INTEGER, bookPath TEXT, qty INTEGER)'
    //   );
    // await db.execute(
    //     'CREATE TABLE transaction(id INTEGER , userId INTEGER, purchaseDate DATE, totalPrice INTEGER, totalItem INTEGER)'
    //   );
  }

  //cart

  Future<Cart> insertCart(Cart cart) async {
    var dbClient = await database;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> deleteCartItem(int bookId, int userId) async {
    var dbClient = await database;
    return await dbClient!.delete('cart', where: 'bookId = ? AND userId = ?', whereArgs: [bookId, userId]);
    // return await dbClient!.rawDelete(sql)
  }

  // Future<int> updateQuantity(Cart cart) async {
  //   var dbClient = await database;
  //   // return await dbClient!.update('cart', cart.quantityMap(),
  //   //     where: "id = ? AND userId = ?", whereArgs: [cart.id, cart.userId]);
  //   int res = await dbClient!.update('cart', cart.quantityMap(), where: "id = ? AND userId = ?", whereArgs: [cart.id, cart.userId]);
  //   print(res);
  //   return res;
  //   // print(cart.quantity!.value);
  //   // return await dbClient!.rawUpdate('UPDATE cart SET quantity = ${cart.quantity!.value}  WHERE id = ${cart.id} AND userId = ${cart.userId}');
  // }

  Future<int> updateQuantity(Cart cart) async {
    final dbClient = await database;
    final res = await dbClient!.update('cart', cart.quantityMap(), where: "bookId = ? AND userId = ?", whereArgs: [cart.bookId, cart.userId]);
    // final res = await dbClient!.rawQuery('UPDATE cart SET quantity = ${cart.quantity!.value}  WHERE id = ${cart.id} AND userId = ${cart.userId}');
    // final List<Map<String, Object?>> queryResult = await dbClient.query('cart');
    // print(queryResult);
    // print(cart.id);
    // print(cart.quantity!.value);
    // print(cart.userId);
    // print(res);
    // final res2 = await dbClient!.delete('cart', where: 'id = ? AND userId = ?', whereArgs: [cart.id, cart.userId]);
    // await dbClient.insert('cart', cart.toMap());
    return res;
  }

  Future<List<Cart>> getCartId(int id) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryIdResult =
        await dbClient!.query('cart', where: 'id = ?', whereArgs: [id]);
    return queryIdResult.map((e) => Cart.fromMap(e)).toList();
  }

  deleteAll() async{
    final db = await database;
    return db!.rawQuery("DELETE FROM cart");
  }

  deleteAfterPayment(int userId) async{
    final db = await database;
    return await db!.delete('cart', where: 'userId = ?', whereArgs: [userId]);
  }

  // deleteAfterPayment2(int userId) async{
  //   final db = await database;
  //   return await db!.rawQuery("DELETE FROM cart WHERE userId = userId");
  // }

  //user

  Future<List<User>> getUser() async{
    final db = await database;
    var users = await db!.query('user', orderBy: 'id');
    List<User> userList = users.isNotEmpty ?
      users.map((e) => User.fromMap(e)).toList()
      : [];
    return userList;
  }

  Future<User> addUser(User user) async{
    var db = await database;
    await db!.insert('user', user.toMap());
    return user;
  }

  Future<int> deleteUser(int id) async{
    var db = await database;
    return await db!.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateUser(User user) async{
    var db = await database;
    return await db!.update('user', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> getAmountUser() async{
    var db = await database;
    // int amount = Sqflite.firstIntValue(await db!.rawQuery('SELECT * FROM user')) ?? 0;
    // int amount = (await db!.query("SELECT COUNT (*) FROM user")).length;
    int amount = Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT (*) FROM user')) ?? 0;
    return amount; 
  }

  //history

  Future<List<History>> getHistory() async{
    final db = await database;
    var histories = await db!.query('history', orderBy: 'id');
    List<History> historyList = histories.isNotEmpty ?
      histories.map((e) => History.fromMap(e)).toList()
      : [];
    return historyList;
  }

  Future<History> addHistory(History history) async{
    var db = await database;
    await db!.insert('history', history.toMap());
    return history;
  }

  Future<int> deleteHistory(int id) async{
    var db = await database;
    return await db!.delete('history', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> getAmountHistory() async{
    var db = await database;
    // int amount = Sqflite.firstIntValue(await db!.rawQuery('SELECT * FROM user')) ?? 0;
    // int amount = (await db!.query("SELECT COUNT (*) FROM user")).length;
    int amount = Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT (*) FROM history')) ?? 0;
    return amount; 
  }

}