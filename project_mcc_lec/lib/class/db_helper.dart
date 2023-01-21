import 'package:project_mcc_lec/class/cart_model.dart';
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
        'CREATE TABLE cart(id INTEGER PRIMARY KEY, bookTitle VARCHAR UNIQUE, bookPrice INTEGER, quantity INTEGER, bookPath TEXT)'
      );
    await db.execute(
        'CREATE TABLE user( id INTEGER PRIMARY KEY, username VARCHAR UNIQUE, email TEXT, password TEXT, profileImage TEXT)'
      );
    // await db.execute(
    //     'CREATE TABLE history(id INTEGER PRIMARY KEY, userId INTEGER, totalPrice INTEGER, date DATE)'
    //   );
  }

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

  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await database;
    return await dbClient!.update('cart', cart.quantityMap(),
        where: "id = ?", whereArgs: [cart.id]);
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

}