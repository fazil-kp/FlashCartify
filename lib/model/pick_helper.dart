import 'package:zomato_project/model/pick_item_mode.dart';

class PickHelper {
  static var statusList = [
    PickItemModel(
        name: 'New York Pizza',
        deliveryPrice: '90',
        remaingTime: '30 min',
        image: "assets/pizza.jpg",
        ratting: '4.8',
        subTitle: 'New York',
        totalRating: '1.2k'),
    PickItemModel(
        name: 'Burger Lab',
        deliveryPrice: '50',
        remaingTime: '25 min',
        image: "assets/burger.jpg",
        ratting: '4.2',
        subTitle: 'Burgers',
        totalRating: '230'),
    PickItemModel(
        name: 'Jans Delights',
        deliveryPrice: '600',
        remaingTime: '20 min',
        image: "assets/noddels.jpg",
        ratting: '2.5',
        subTitle: "Pakistani",
        totalRating: '400'),
  ];

  static PickItemModel getStatusItem(int position) {
    return statusList[position];
  }

  static var itemCount = statusList.length;
}
