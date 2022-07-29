import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_project/res/components/round_button.dart';
import 'package:mvvm_project/utils/routes/routes_name.dart';
import 'package:mvvm_project/utils/utils.dart';
import 'package:mvvm_project/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Email",
                labelText: "Email",
                prefixIcon: Icon(Icons.mail),
              ),
              onFieldSubmitted: (valu) {
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
            ),

            /**Value listenable builder is for obscure password  */
            ValueListenableBuilder(
                valueListenable: _obscurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword.value,
                      obscuringCharacter: "*",
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: InkWell(
                            onTap: () {
                              _obscurePassword.value = !_obscurePassword.value;
                            },
                            child: Icon(_obscurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility)),
                      ));
                }),
            SizedBox(
              height: height * 0.05,
            ),
            RoundButton(
                title: "Login",
                loading: authViewModel.loading,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    log("email is empty");
                    Utils.flushBarErrorMessage(
                        "Please enter your semail", context);
                  } else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter your password", context);
                  } else if (_passwordController.text.length < 6) {
                    Utils.snackBar(
                        "Password should be greater than 6", context);
                  } else {
                    Map data = {
                      "email": _emailController.text.toString(),
                      "password": _passwordController.text.toString(),
                    };
                    authViewModel.loginApi(data, context);
                    log("Data: ${data.toString()}");
                    // print("Api hit");
                  }
                }),
            SizedBox(height: height * 0.05),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.signUp);
                },
                child: const Text("Don't have an account?"))
          ],
        ),
      ),
    );
  }
}
