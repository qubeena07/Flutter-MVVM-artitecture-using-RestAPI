import 'dart:developer';

import 'package:mvvm_project/data/network/BaseApiServices.dart';
import 'package:mvvm_project/data/network/NetworkApiService.dart';
import 'package:mvvm_project/model/cart_model.dart';
import 'package:mvvm_project/res/app_url.dart';

class HomeRespository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<CartListModel> fetchCartList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.cartEndPoint);
      log(response.toString());
      return response = CartListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
