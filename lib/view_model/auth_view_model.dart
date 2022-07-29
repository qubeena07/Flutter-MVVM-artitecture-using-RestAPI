import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/respository/auth_repository.dart';
import 'package:mvvm_project/utils/routes/routes_name.dart';
import 'package:mvvm_project/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  bool _signUploading = false;
  bool get signUploading => _signUploading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUploading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    log("new Data : ${data.toString()}");
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage("Login Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        log("value----${value.toString()}");
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        log("error----${error.toString()}");
      }
    });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.registerApi(data).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage("Sign Up Sucessfully", context);
      Navigator.pushNamed(context, RoutesName.login);
      if (kDebugMode) {
        log("value----${value.toString()}");
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
      }
    });
  }
}
