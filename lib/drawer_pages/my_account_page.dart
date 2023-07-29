import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zomato_project/reusable_widget/color_utils.dart';

import '../model/user_model.dart';
import '../reusable_widget/constants.dart';

class MyAccounPage extends StatefulWidget {
  const MyAccounPage({super.key});

  @override
  State<MyAccounPage> createState() => _MyAccounPageState();
}

class _MyAccounPageState extends State<MyAccounPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? imageUrl;
  final storage = FirebaseStorage.instance;

  Future<String?> getImageUrl() async {
    try {
      final ref = storage.ref().child('profile.jpeg');
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data() ?? {});
      setState(() {});
    });

    // Call getImageUrl using await and update the imageUrl in the state
    getImageUrl().then((url) {
      setState(() {
        imageUrl = url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
          style: TextStyle(fontFamily: Bold, fontSize: 16, color: blackColor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: height * .25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  // border: Border
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: CircleAvatar(
                          radius: 60,
                          // Display the image only when imageUrl is not null or empty
                          child: imageUrl == null
                              ? Icon(Icons.person, size: 100, color: Colors.white70)
                              : imageUrl!.isEmpty
                              ? CircularProgressIndicator()
                              : Image.network(imageUrl!),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${loggedInUser.firstName} ${loggedInUser.secondName}",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: Bold,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${loggedInUser.email}",
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: Medium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
