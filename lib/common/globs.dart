import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:fruitmarket/main.dart';

class Globs {
  static const appName = "Fruit Market";

  static const userPayload = "user_payload";
  static const userLogin = "user_login";

  static void showHUD({String status = "loading ...."}) async {
    await Future.delayed(const Duration(milliseconds: 1));
    EasyLoading.show(status: status);
  }

  static void hideHUD() {
    EasyLoading.dismiss();
  }

  static void udSet(dynamic data, String key) {
    var jsonStr = json.encode(data);
    prefs?.setString(key, jsonStr);
  }

  static void udStringSet(String data, String key) {
    prefs?.setString(key, data);
  }

  static void udBoolSet(bool data, String key) {
    prefs?.setBool(key, data);
  }

  static void udIntSet(int data, String key) {
    prefs?.setInt(key, data);
  }

  static void udDoubleSet(double data, String key) {
    prefs?.setDouble(key, data);
  }

  static dynamic udValue(String key) {
    return jsonDecode(prefs?.get(key) as String? ?? "{}");
  }

  static String udValueString(String key) {
    return prefs?.getString(key) ?? "";
  }

  static bool udValueBool(String key) {
    return prefs?.getBool(key) ?? false;
  }

  static bool udValueTrueBool(String key) {
    return prefs?.getBool(key) ?? true;
  }

  static int udValueInt(String key) {
    return prefs?.getInt(key) ?? 0;
  }

  static double udValueDouble(String key) {
    return prefs?.getDouble(key) ?? 0.0;
  }

  static void udRemove(String key) {
    prefs?.remove(key);
  }

  static Future<String> timeZone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } catch (e) {
      return "";
    }
  }
}

class SVKey {
  static const mainUrl = "http://localhost:3003";
  static const nodeUrl = mainUrl;
  static const baseUrl = '$mainUrl/api';

  static const login = '$baseUrl/app/login';
  static const verifyOtp = '$baseUrl/app/verify_login_otp';

  static const adminMainCategoryList = '$baseUrl/admin/main_category_list';
  static const adminMainCategoryAdd = '$baseUrl/admin/main_category_add';
  static const adminMainCategoryUpdate = '$baseUrl/admin/main_category_update';
  static const adminMainCategoryDelete = '$baseUrl/admin/main_category_delete';
  static const adminMainCategoryActiveInactive =
      '$baseUrl/admin/main_category_active_inactive';

  static const adminCategoryList = '$baseUrl/admin/category_list';
  static const adminCategoryAdd = '$baseUrl/admin/category_add';
  static const adminCategoryUpdate = '$baseUrl/admin/category_update';
  static const adminCategoryDelete = '$baseUrl/admin/category_delete';
  static const adminCategoryActiveInactive =
      '$baseUrl/admin/category_active_inactive';

  static const adminUnitList = '$baseUrl/admin/unit_list';
  static const adminUnitAdd = '$baseUrl/admin/unit_add';
  static const adminUnitUpdate = '$baseUrl/admin/unit_update';
  static const adminUnitDelete = '$baseUrl/admin/unit_delete';

  static const adminItemList = '$baseUrl/admin/items_list';
  static const adminAllItemList = '$baseUrl/admin/all_items_list';
  static const adminItemAdd = '$baseUrl/admin/item_add';
  static const adminItemUpdate = '$baseUrl/admin/item_update';
  static const adminItemDelete = '$baseUrl/admin/item_delete';
  static const adminItemImageUpdate = '$baseUrl/admin/item_update_image';
  static const adminItemReviewList = '$baseUrl/admin/show_all_review_list';
  static const adminItemReviewDelete = '$baseUrl/admin/review_delete';

  static const adminItemNutritionList = '$baseUrl/admin/item_nutrition_list';
  static const adminItemNutritionAdd = '$baseUrl/admin/item_nutrition_add';
  static const adminItemNutritionUpdate =
      '$baseUrl/admin/item_nutrition_update';
  static const adminItemNutritionDelete =
      '$baseUrl/admin/item_nutrition_delete';

  static const adminItemPriceList = '$baseUrl/admin/item_price_list';
  static const adminItemPriceAdd = '$baseUrl/admin/item_price_add_update';
  static const adminItemPriceDelete = '$baseUrl/admin/item_price_delete';

  static const adminOfferCreate = '$baseUrl/admin/offer_create';
  static const adminOfferList = '$baseUrl/admin/offer_list';
  static const adminOfferUpdate = '$baseUrl/admin/offer_update';
  static const adminOfferDelete = '$baseUrl/admin/offer_delete';

  static const adminDashboard = '$baseUrl/admin/dashboard';
  static const deliveryBoyDashboard = '$baseUrl/app/delivery_boy_dashboard';

  static const adminDeliveryBoyUserList =
      '$baseUrl/admin/delivery_boy_user_list';
  static const adminDeliveryBoyUserAdd = '$baseUrl/admin/delivery_boy_create';
  static const adminDeliveryBoyUserUpdate =
      '$baseUrl/admin/delivery_boy_update';
  static const adminDeliveryBoyUserDelete =
      '$baseUrl/admin/delivery_boy_delete';
  static const adminDeliveryBoyUserAssignOrder =
      '$baseUrl/admin/delivery_assign_order_for_delivery';

  static const adminNewOrderList = '$baseUrl/admin/new_orders_list';
  static const adminOrderItemAcceptReject =
      '$baseUrl/admin/order_item_accept_reject';

  static const mainCategoryList = '$baseUrl/app/main_category_list';
  static const home = '$baseUrl/app/home';
  static const itemDetail = '$baseUrl/app/item_details';
  static const addToCart = '$baseUrl/app/cart_to_add';
  static const cartList = '$baseUrl/app/cart_list';
  static const cartQTYUpdate = '$baseUrl/app/cart_qty_update';
  static const cartDelete = '$baseUrl/app/cart_item_delete';

  static const addressList = '$baseUrl/app/address_list';
  static const addressAdd = '$baseUrl/app/address_add';
  static const addressUpdate = '$baseUrl/app/address_update';
  static const addressDelete = '$baseUrl/app/address_delete';

  static const orderPlace = '$baseUrl/app/order_place';
  static const myOrdersList = '$baseUrl/app/my_order_list';
  static const giveReview = '$baseUrl/app/give_review';

  static const deliveryNewOrderList = '$baseUrl/app/deliver_boy_order_list';
  static const deliveryBoyOrderOutForDelivery =
      '$baseUrl/app/deliver_boy_order_out_for_deliver';
  static const deliveryBoyOrderDelivered =
      '$baseUrl/app/deliver_boy_order_delivered';
  static const deliveryBoyOrderDeliverCancel =
      '$baseUrl/app/delivery_boy_order_deliver_cancel';
}

class KKey {
  static const payload = "payload";
  static const status = "status";
  static const message = "message";
  static const userType = "user_type";
  static const authToken = "auth_token";
}

class MSG {
  static const success = "success";
  static const fail = "fail";
}
