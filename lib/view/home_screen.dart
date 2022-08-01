import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_project/data/response/status.dart';
import 'package:mvvm_project/utils/routes/routes_name.dart';
import 'package:mvvm_project/view_model/home_view_model.dart';
import 'package:mvvm_project/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchCartListApi();
    log(homeViewViewModel.fetchCartListApi().toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home"),
        actions: [
          InkWell(
              onTap: () {
                userPreference.remove().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: const Center(child: Text("Logout"))),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: ((context, value, _) {
            log("Data list${value.cartsList.message.toString()}");
            switch (value.cartsList.status) {
              case Status.LOADING:
                return const CircularProgressIndicator();
              case Status.ERROR:
                return Text(value.cartsList.message.toString());
              case Status.COMPLETED:
                return ListView.builder(
                    itemCount: value.cartsList.data!.carts!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(value.cartsList.data!.carts![index].id
                              // .products![index].title
                              .toString()),
                          leading: Text(
                              "UserID-${value.cartsList.data!.carts![index].userId}"),
                          subtitle: Text(
                              "TotalProducts-${value.cartsList.data!.carts![index].totalProducts}"),
                        ),
                      );
                    });
            }
            return Container();
          }),
        ),
      ),
    );
  }
}
