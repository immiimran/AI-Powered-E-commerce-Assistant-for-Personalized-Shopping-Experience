import 'package:flutter/material.dart';
import '../../const/colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome to Smart Shop 🛍️",
              style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.06,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: h * 0.02),
          Text("Your personalized AI-powered shopping experience.",
              style: TextStyle(color: Colors.white70, fontSize: w * 0.04)),
          SizedBox(height: h * 0.05),
          Expanded(
            child: GridView.builder(
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: w > 600 ? 3 : 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: listTileColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag, color: primaryColor, size: w * 0.15),
                      SizedBox(height: h * 0.015),
                      Text(
                        "Product ${index + 1}",
                        style: TextStyle(color: Colors.white, fontSize: w * 0.04),
                      ),
                      SizedBox(height: h * 0.005),
                      Text("৳ ${(index + 1) * 500}",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
