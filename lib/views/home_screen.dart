// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../const/colors.dart';

// Your screens
import 'tab/ai_tab.dart';
import 'tab/home_tab.dart';
import 'tab/profile_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  final List<Widget> screens = [
    HomeTab(),   // 0
    AITab(),     // 1
    Container(), // 2 (Floating button dummy)
    Container(), // 3 Cart
    ProfileTab(),// 4 Chat/Profile
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,

      body: Obx(() => screens[controller.currentIndex.value]),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          controller.changeTab(2);
        },
        child: Icon(Icons.add, size: 32),
      ),

      bottomNavigationBar: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          height: 70,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background Bar
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                ),
              ),

              // Navigation Items
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(
                    index: 0,
                    icon: Icons.home_filled,
                    label: "Home",
                    controller: controller,
                  ),
                  _navItem(
                    index: 1,
                    icon: Icons.smart_toy,
                    label: "AI",
                    controller: controller,
                  ),

                  /// spacing for FAB
                  SizedBox(width: 55),

                  _navItem(
                    index: 3,
                    icon: Icons.shopping_cart,
                    label: "Cart",
                    controller: controller,
                  ),
                  _navItem(
                    index: 4,
                    icon: Icons.chat_bubble,
                    label: "Chat",
                    controller: controller,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
    required HomeController controller,
  }) {
    bool isActive = controller.currentIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 220),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? primaryColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: isActive ? primaryColor : Colors.grey,
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? primaryColor : Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
