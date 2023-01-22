// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_mcc_lec/page/paymentpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.currentUserId}) : super(key: key);

  final int currentUserId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String defaultImage = 'assets/Logo/profile_default.jpg';

  File? pickedGalleryImage;

  Future PickGalleryImage() async{
    XFile? galleryImage;
    try{
      galleryImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(galleryImage == null){
        return;
      }else{
        setState(() {
          pickedGalleryImage = File(galleryImage!.path);
        });
      }

    } on PlatformException{
      print("Unable to pick Image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: pickedGalleryImage == null
                            ? DecorationImage(
                                image: AssetImage(defaultImage), scale: 0.3)
                            : DecorationImage(
                                image: FileImage(pickedGalleryImage!),
                                fit: BoxFit.cover)
                        ),
                  ),
                  Container(
                    
                    // alignment: Alignment.center,
                    height: 45,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.deepOrange, 
                      shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () async {
                        PickGalleryImage();
                        //jgn lupa save ke database
                      },
                      icon: const Icon(
                        Icons.collections_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    )),
                ],
              ),
            ),
            SizedBox(height: 10,),
            SeparatorLine(),
            SizedBox(height: 25,),
            ProfileTitleText(title: 'Username'),
            ProfileSubtitleText(title: 'ganti ke user username'),
            SizedBox(height: 25,),
            ProfileTitleText(title: 'Email'),
            ProfileSubtitleText(title: 'ganti ke user email'),
            SizedBox(height: 25,),
            ProfileTitleText(title: 'Phone Number'),
            ProfileSubtitleText(title: 'ganti ke user phone number'),
          ],
        ),
      ),
    );
  }
}


class ProfileTitleText extends StatelessWidget {
  const ProfileTitleText({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}

class ProfileSubtitleText extends StatelessWidget {
  const ProfileSubtitleText({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}


