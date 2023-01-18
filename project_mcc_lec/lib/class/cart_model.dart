import 'package:flutter/material.dart';
import 'package:project_mcc_lec/class/book.dart';

class Cart {
  late final int? id;
  final String? bookTitle; 
  final int? bookPrice; 
  final ValueNotifier<int>? quantity;
  // final String? unitTag;
  final String? bookPath;

  // final Book? book;
  

  Cart(
      {required this.id,
      required this.bookTitle,
      required this.bookPrice,
      required this.quantity,
      required this.bookPath
      // required this.book
    });

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        bookTitle = data['bookTitle'],
        bookPrice = data['bookPrice'],
        quantity = ValueNotifier(data['quantity']),
        bookPath = data['bookPath'];
        // book = data['book'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookTitle': bookTitle,
      'bookPrice': bookPrice,
      'quantity': quantity?.value,
      'bookPath': bookPath
      // 'bookTitle': book?.bookTitle,
      // 'bookPrice': book?.bookPrice,
      // 'quantity': quantity?.value,
      // 'bookPath': book?.bookPath
    };
  }

  Map<String, dynamic> quantityMap() {
    return {
      'id': id,
      'quantity': quantity!.value,
    };
  }
}