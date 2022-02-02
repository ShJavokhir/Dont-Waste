import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        leading: Icon(
          Icons.menu_rounded,
        ),
        title: Text(
          'Waste2Cash',
        ),
      ),
      body: Center(
        child: Text(
          'HomeView is working',
        ),
      ),
    );
  }
}
