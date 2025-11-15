import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_shop/views/tab/profile_tab.dart';
import '../controllers/home_controller.dart';
import '../const/colors.dart';
import 'tab/ai_tab.dart';
import 'tab/home_tab.dart';


// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final List<Widget> screens = [
    HomeTab(),
    AITab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      body: Obx(() => screens[controller.currentIndex.value]),

      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          backgroundColor: listTileColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "AI"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
