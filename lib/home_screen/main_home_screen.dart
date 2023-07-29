import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zomato_project/model/item_helper.dart';
import 'package:zomato_project/model/item_model.dart';
import 'package:zomato_project/reusable_widget/color_utils.dart';

import '../components/restaurent.dart';
import '../model/pick_helper.dart';
import '../model/pick_item_mode.dart';
import '../reusable_widget/constants.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
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
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.filter_list_outlined,
                  color: MyColors.primaryColor,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Container(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Zomato Pick",
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
                Text(
                  "Zomato Exclusive",
                  style: TextStyle(
                      color: blackColor, fontSize: 15, fontFamily: Bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .278,
                    child: ListView.builder(
                        itemCount: ExclusiveHelper.itemCount,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          ExclusiveItemModel model =
                              ExclusiveHelper.getStatusItem(index);
                          return RestaurentScreen(
                              name: model.name,
                              image: model.image,
                              remainingTime: model.remainingTime,
                              totalRating: model.totalRating,
                              subTitle: model.subTitle,
                              rating: model.rating,
                              deliveryTime: model.remainingTime,
                              deliveryPrice: model.deliveryPrice);
                        }),
                  ),
                ),
                Text(
                  "All Restaurents",
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
      ),
    );
  }
}
