
class User{
  late final int? id;
  final String username;
  final String email;
  final String phoneNumber;
  final String password;
  final String? profileImage;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.profileImage
  });

  // User.fromMap(Map<dynamic, dynamic> data)
  //     : id = data['id'],
  //       username = data['username'],
  //       email = data['email'],
  //       password = data['password'],
  //       profileImage = data['profileImage'];

  factory User.fromMap(Map<dynamic, dynamic> data) => new User(
    id: data['id'], 
    username: data['username'], 
    email: data['email'],
    phoneNumber: data['phoneNumber'], 
    password: data['password'], 
    profileImage: data['profileImage']
  );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username' : username,
      'email' : email,
      'phoneNumber' : phoneNumber,
      'password' : password,
      'profileImage' : profileImage
    };
  }

}


// class User {
//   late String username;
//   late String email;
//   late String password;

//   User (String username, String email, String password){
//     this.username = username;
//     this.email = email;
//     this.password = password;
//   }
// }