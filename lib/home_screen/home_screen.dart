// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../model/user_model.dart';
// import 'login_screen.dart';
//
//
// class ZomatoHomePage extends StatefulWidget {
//   const ZomatoHomePage({super.key});
//
//   @override
//   State<ZomatoHomePage> createState() => _ZomatoHomePageState();
// }
//
// class _ZomatoHomePageState extends State<ZomatoHomePage> {
//   User? user = FirebaseAuth.instance.currentUser;
//   UserModel loggedInUser = UserModel();
//
//   @override
//   void initState() {
//     super.initState();
//     FirebaseFirestore.instance
//         .collection("user")
//         .doc(user!.uid)
//         .get()
//         .then((value) {
//       this.loggedInUser = UserModel.fromMap(value.data());
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Welcome"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 150,
//                 child: Image.asset("assets/images/zomoto_splash.png", fit: BoxFit.contain),
//               ),
//               Text(
//                 "Welcome Back",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontWeight: FontWeight.w500,
//                   )),
//               Text("${loggedInUser.email}",
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontWeight: FontWeight.w500,
//                   )),
//               SizedBox(
//                 height: 15,
//               ),
//               ActionChip(
//                   label: Text("Logout"),
//                   onPressed: () {
//                     logout(context);
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // the logout function
//   Future<void> logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => LoginScreen()));
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zomato_project/components/restaurent.dart';
import 'package:zomato_project/drawer_pages/help_page.dart';
import 'package:zomato_project/drawer_pages/location_page.dart';
import 'package:zomato_project/drawer_pages/my_account_page.dart';
import 'package:zomato_project/home_screen/main_home_screen.dart';
import 'package:zomato_project/model/pick_helper.dart';
import 'package:zomato_project/model/pick_item_mode.dart';
import 'package:zomato_project/reusable_widget/color_utils.dart';
import 'package:zomato_project/reusable_widget/constants.dart';

import '../drawer_pages/settings_page.dart';
import '../screens/login_screen.dart';

class ZomatoHomePage extends StatefulWidget {
  const ZomatoHomePage({super.key});

  @override
  State<ZomatoHomePage> createState() => _ZomatoHomePageState();
}

class _ZomatoHomePageState extends State<ZomatoHomePage> {
  late String imageUrl;
  final storage = FirebaseStorage.instance;

  // @override
  // void initState(){
  //   super.initState();
  //   imageUrl='';
  //   getImageUrl();
  // }

  Future getImageUrl() async {
    final ref = storage.ref().child('profile.jpeg');
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    imageUrl = '';
    getImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kochi",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                    placeholder: "Search for shop & Restaurants",
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Color(0xff7b7b7b),
                      ),
                    ),
                    style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: 12,
                        fontFamily: Regular),
                    decoration: BoxDecoration(
                      color: Color(0xfff7f7f7),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        // backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAccounPage()));
              },
              child: ListTile(
                title: Text(
                  "My Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: Medium,
                  ),
                ),
                leading: Icon(
                  Icons.person_outline,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              child: ListTile(
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: Medium,
                  ),
                ),
                leading: Icon(
                  Icons.settings_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LocationPage()));
              },
              child: ListTile(
                title: Text(
                  "Location",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: Medium,
                  ),
                ),
                leading: Icon(
                  Icons.location_on_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HelpPage()));
              },
              child: ListTile(
                title: Text(
                  "Help",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: Medium,
                  ),
                ),
                leading: Icon(
                  Icons.help_outline,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                logout(context);
              },
              child: ListTile(
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: Medium,
                  ),
                ),
                leading: Icon(
                  Icons.logout_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainHomeScreen()));
                  },
                  child: Container(
                    height: height * .19,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image(
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          image: AssetImage("assets/food.jpg"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Food Delivery",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: Bold),
                              ),
                              Text(
                                "Order from your faviruite \n restaurants and home chefs",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                    fontFamily: Medium),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: height * .25,
                        decoration: BoxDecoration(
                          color: Color(0xfffed271),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage('assets/mart.jpg'),
                              ),
                              Positioned(
                                  bottom: 15,
                                  left: 0,
                                  child: Text(
                                    "Zomato",
                                    style: TextStyle(
                                        color: blackColor,
                                        fontFamily: Bold,
                                        fontSize: 18),
                                  )),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Text(
                                    "Zomato20 for 20 %off",
                                    style: TextStyle(
                                        color: blackColor,
                                        fontFamily: Medium,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: height * .15,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffef9fc4),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/food.jpg"),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pick-Up",
                                    style: TextStyle(
                                        color: blackColor,
                                        fontFamily: Bold,
                                        fontSize: 19),
                                  ),
                                  Text(
                                    "Upto 50% off",
                                    style: TextStyle(
                                        color: blackColor, fontFamily: Medium),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: height * .1,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xff85bfff),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shops",
                                    style: TextStyle(
                                        color: blackColor,
                                        fontFamily: Bold,
                                        fontSize: 19),
                                  ),
                                  Text(
                                    "Everyday assentials",
                                    style: TextStyle(
                                        color: blackColor, fontFamily: Medium),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Your daily deals",
                style: TextStyle(
                    color: blackColor, fontSize: 15, fontFamily: Bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: height * .278,
                  child: ListView.builder(
                      itemCount: PickHelper.itemCount,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        PickItemModel model = PickHelper.getStatusItem(index);
                        return RestaurentScreen(
                            name: model.name,
                            image: model.image,
                            remainingTime: model.remaingTime,
                            totalRating: model.totalRating,
                            subTitle: model.subTitle,
                            rating: model.ratting,
                            deliveryTime: model.remaingTime,
                            deliveryPrice: model.deliveryPrice);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
