import 'package:flutter/material.dart';
import 'package:mvvm_project/data/response/api_response.dart';
import 'package:mvvm_project/model/cart_model.dart';
import 'package:mvvm_project/respository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRespository();
  ApiResponse<CartListModel> cartsList = ApiResponse.loading();

  setCartList(ApiResponse<CartListModel> response) {
    cartsList = response;
    notifyListeners();
  }

  Future<void> fetchCartListApi() async {
    setCartList(ApiResponse.loading());

    _myRepo.fetchCartList().then((value) {
      setCartList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCartList(ApiResponse.error(error.toString()));
    });
  }
}
