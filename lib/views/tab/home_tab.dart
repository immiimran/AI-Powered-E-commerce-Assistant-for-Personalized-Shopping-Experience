import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const/colors.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  final RxInt currentSlide = 0.obs;

  final List<String> bannerImages = [
    "assets/images/banner1.jpg"
        "assets/images/b2.jpg",
    "assets/images/banner3.png",
  ];

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.checkroom, "title": "Clothes"},
    {"icon": Icons.devices_other, "title": "Electronics"},
    {"icon": Icons.shopping_bag, "title": "Shoes"},
    {"icon": Icons.watch, "title": "Watch"},
  ];

  final List<String> filters = ["All", "Newest", "Popular", "Clothes"];
  final RxString selectedFilter = "All".obs;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_pin, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      "IIT, Jahangirnagar University",
                      style:
                          TextStyle(color: Colors.white, fontSize: w * 0.045),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ],
                ),
                Icon(Icons.notifications_none, color: Colors.white, size: 28),
              ],
            ),

            SizedBox(height: h * 0.02),

            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),

            SizedBox(height: h * 0.02),

            // Slider
            Obx(() => Column(
                  children: [
                    CarouselSlider(
                      items: bannerImages
                          .map((img) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(img),
                                      fit: BoxFit.cover),
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: h * 0.22,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        onPageChanged: (index, reason) {
                          currentSlide.value = index;
                        },
                      ),
                    ),

                    // slider indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        bannerImages.length,
                        (index) => Container(
                          width: currentSlide.value == index ? 20 : 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentSlide.value == index
                                ? primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                )),

            SizedBox(height: h * 0.025),

            // 📂 Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: categories.map((cat) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: w * 0.075,
                      backgroundColor: primaryColor.withOpacity(0.2),
                      child: Icon(cat["icon"],
                          color: primaryColor, size: w * 0.08),
                    ),
                    SizedBox(height: 8),
                    Text(cat["title"],
                        style:
                            TextStyle(color: Colors.white, fontSize: w * 0.04))
                  ],
                );
              }).toList(),
            ),

            SizedBox(height: h * 0.03),

            // Flash Sale
            Text(
              "Flash Sale",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.055,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Filter Chips
            Obx(() => Wrap(
                  spacing: 10,
                  children: filters.map((f) {
                    return ChoiceChip(
                      label: Text(f),
                      selected: selectedFilter.value == f,
                      selectedColor: primaryColor,
                      backgroundColor: Colors.white24,
                      labelStyle: TextStyle(
                          color: selectedFilter.value == f
                              ? Colors.grey[800]
                              : Colors.grey[600]),
                      onSelected: (_) => selectedFilter.value = f,
                    );
                  }).toList(),
                )),

            SizedBox(height: h * 0.02),

            // Flash Sale Products
            SizedBox(
              height: h * 0.23,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    width: w * 0.4,
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: listTileColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag,
                            color: primaryColor, size: w * 0.15),
                        SizedBox(height: 10),
                        Text("Product ${index + 1}",
                            style: TextStyle(color: Colors.white)),
                        Text("৳ ${(index + 1) * 500}",
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }
}
