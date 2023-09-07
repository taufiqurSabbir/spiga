import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:laspigadoro/owner/model/AllUser.dart';

import '../../api/api.dart';
import '../../api/api_get_calls.dart';
import '../../helper/helper_function.dart';
import '../model/Boutique.dart';
import '../model/Food.dart';
import '../model/Order.dart';

class MesCommandesAdminControllerOwner extends GetxController {
  final showLoader = true.obs;

  List<OrdersWithOrderDateInDateTimeObj> orderArrayWithOrderDateInDateTimeObj= <OrdersWithOrderDateInDateTimeObj>[];
  List<String> foodName =<String>[];
  List<String> shopName =<String>[];
  List<dynamic> price = <dynamic>[];
  List<AllUsers> selectedUser = <AllUsers>[];


  getOrderList() async {

    List<Order> mainOrderArray = <Order>[];

    orderArrayWithOrderDateInDateTimeObj = [];
    foodName =<String>[];
    shopName =<String>[];
    price = <dynamic>[];
    selectedUser = <AllUsers>[];

    showLoader.value = true;

    List<Food> foodOffersArr = <Food>[];
    List<Boutique> boutiqueArray = <Boutique>[];
    List<AllUsers> allUser = <AllUsers>[];

    foodOffersArr = await geFoodOffersArr();
    boutiqueArray = await getBotiqueList();
    allUser = await getUsers();

    var response = await ApiGetCalls.getApiResponse(Api.orderApi);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data.length > 0) {
        for (var i = 0; i < data[0].length; i++) {
          mainOrderArray.add(Order.fromJson(data[0][i]));
        }

        for (var i = 0; i < mainOrderArray.length; i++) {
          orderArrayWithOrderDateInDateTimeObj.add(OrdersWithOrderDateInDateTimeObj(
            mainOrderArray[i].id,
            mainOrderArray[i].foodId,
            mainOrderArray[i].customerName,
            mainOrderArray[i].paymentStatus,
            mainOrderArray[i].pickupTime,
            DateTime.parse(mainOrderArray[i].orderDate!),
            mainOrderArray[i].createdAt,
            mainOrderArray[i].updatedAt,
            mainOrderArray[i].quantity,
            mainOrderArray[i].userId,
            mainOrderArray[i].transactionId,
            mainOrderArray[i].orderStatus,
            mainOrderArray[i].order,
            mainOrderArray[i].netPrice,
            mainOrderArray[i].totalPrice,
            mainOrderArray[i].customerPickupTimeFrom,
            mainOrderArray[i].customerPickupTimeTo,
            mainOrderArray[i].refundId

          ));
        }
        orderArrayWithOrderDateInDateTimeObj.sort((a, b) => b.orderDate!.compareTo(a.orderDate!));


        for (var i = 0; i < orderArrayWithOrderDateInDateTimeObj.length; i++) {
          for (var j = 0; j < foodOffersArr.length; j++) {
            if ( foodOffersArr[j].id ==orderArrayWithOrderDateInDateTimeObj[i].foodId) {

              foodName.add(foodOffersArr[j].foodName!);
              price.add(foodOffersArr[j].price);

              for (var k = 0; k < boutiqueArray.length; k++) {
                if ( boutiqueArray[k].id == foodOffersArr[j].boutiqueId) {
                  shopName.add(boutiqueArray[k].boutiqueName!);
                  break;
                }
              }


              break;
            }
          }
          for (var l = 0; l < allUser.length; l++) {
            if ( allUser[l].id == orderArrayWithOrderDateInDateTimeObj[i].userId) {
              selectedUser.add(allUser[l]);
              break;
            }
          }
        }

        showLoader.value = false;

      }
    }
    else {
      showLoader.value = false;

      print("Status Code: ${response.statusCode}");
    }



  }

  getBotiqueList() async {
    List<Boutique> boutiqueArray = <Boutique>[];

    
    var response = await ApiGetCalls.getApiResponse(Api.boutiqueApi);
    if (response.statusCode == 200){
      var data = json.decode(response.body);
      if (data["data"].length > 0) {
        for (var i = 0; i < data["data"].length; i++) {
          boutiqueArray.add(Boutique.fromJson(data["data"][i]));
        }

        return boutiqueArray;
      }
      else{
        return boutiqueArray;
      }
    }
    else{
      return boutiqueArray;
    }
  }
  geFoodOffersArr() async {
    List<Food> foodOffersArr = <Food>[];

    var response = await ApiGetCalls.getApiResponse(Api.listeSurprisApi);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
          foodOffersArr.add(Food.fromJson(data[i]));
        }

        return foodOffersArr;
      }
      else{
        return foodOffersArr;
      }
    }else{
      return foodOffersArr;
    }
  }
  getUsers() async {
    List<AllUsers> allUser = <AllUsers>[];

    var response = await ApiGetCalls.getApiResponse(Api.allUsersApi);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
          allUser.add(AllUsers.fromJson(data[i]));
        }

        return allUser;
      }
      else{
        return allUser;
      }
    }else{
      return allUser;
    }

  }
}