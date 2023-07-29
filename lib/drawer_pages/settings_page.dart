import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zomato_project/drawer_pages/my_account_page.dart';
import 'package:zomato_project/reusable_widget/color_utils.dart';
import 'package:zomato_project/reusable_widget/constants.dart';
import 'package:zomato_project/screens/login_screen.dart';

import '../model/user_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    getImageUrl().then((url) {
      setState(() {
        imageUrl = url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(fontFamily: Bold, fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 10,
          ),
          userTile(),
          divider(),
          colorTiles(),
          divider(),
          bwTiles(),
        ],
      ),
    );
  }

  Widget userTile() {
    return ListTile(
      leading: ClipOval(
        child: CircleAvatar(
          radius: 30,
          // Display the image only when imageUrl is not null or empty
          child: imageUrl == null
              ? Icon(Icons.person, color: Colors.white70)
              : imageUrl!.isEmpty
              ? CircularProgressIndicator()
              : Image.network(imageUrl!),
        ),
      ),
      title: Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
          style: TextStyle(
            color: Colors.black,
            fontFamily: Bold,
            fontWeight: FontWeight.w500,
          )),
      subtitle: Text("${loggedInUser.email}",
          style: TextStyle(
            color: Colors.black,
            fontFamily: Medium,
            fontWeight: FontWeight.w500,
          )),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget colorTiles() {
    return Column(
      children: [
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyAccounPage()));
            },
            child: colorTile(
                Icons.person_outline, Colors.pinkAccent, "Personal data")),
        SizedBox(
          height: 15,
        ),
        colorTile(Icons.notifications, Colors.pinkAccent, "Notifications"),
        SizedBox(
          height: 15,
        ),
        colorTile(Icons.language_outlined, Colors.pinkAccent, "App Language"),
        SizedBox(
          height: 15,
        ),
        colorTile(
            Icons.card_giftcard_outlined, Colors.pinkAccent, "Referral Code"),
        SizedBox(
          height: 15,
        ),
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child:
                colorTile(Icons.logout_outlined, Colors.pinkAccent, "Log Out")),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget colorTile(IconData icon, Color color, String text) {
    return ListTile(
      leading: Container(
        child: Icon(
          icon,
          color: color,
        ),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w400, fontFamily: Medium),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
    );
  }

  Widget bwTiles() {
    Color color = Colors.blueGrey.shade800;
    return Column(
      children: [colorTile(Icons.info_outline, color, "FAQs")],
    );
  }
}
