import 'package:zomato_project/model/item_model.dart';

class ExclusiveHelper {
  static var exclusiveListModel = [
    ExclusiveItemModel(
        name: "Burning Brownies",
        deliveryPrice: "Free Delivery",
        remainingTime: "15 min",
        image: "assets/cake.jpg",
        subTitle: "Backery",
        totalRating: "300",
        rating: "4.3"),
    ExclusiveItemModel(
        name: "OPTP G11",
        deliveryPrice: "50",
        remainingTime: "35 min",
        image: "assets/chicken.jpg",
        subTitle: "Burgers",
        totalRating: "400",
        rating: "4.7"),
    ExclusiveItemModel(
        name: "China Town",
        deliveryPrice: "600",
        remainingTime: "20 min",
        image: "assets/chinese.jpg",
        subTitle: "Chinees",
        totalRating: "500",
        rating: "3.7")
  ];

  static ExclusiveItemModel getStatusItem(int position) {
    return exclusiveListModel[position];
  }

  static var itemCount = exclusiveListModel.length;
}
