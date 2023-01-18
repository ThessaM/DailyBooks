
class Item {
 final String name;
//  final String unit;
 final int price;
 final String image;

 Item({required this.name, required this.price, required this.image});

 Map toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
    };
  }
}


// class Item {
//  final String name;
//  final String unit;
//  final int price;
//  final String image;

//  Item({required this.name, required this.unit, required this.price, required this.image});

//  Map toJson() {
//     return {
//       'name': name,
//       'unit': unit,
//       'price': price,
//       'image': image,
//     };
//   }
// }