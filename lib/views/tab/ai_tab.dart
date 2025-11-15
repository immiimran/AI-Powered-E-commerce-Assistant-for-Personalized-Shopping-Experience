import 'package:flutter/material.dart';
import '../../const/colors.dart';

class AITab extends StatelessWidget {
  final TextEditingController queryController = TextEditingController();

  AITab({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          children: [
            Text("Smart AI Assistant 🤖",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.06,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: h * 0.02),
            Text(
              "Ask AI to suggest the best products for you!",
              style: TextStyle(color: Colors.white70, fontSize: w * 0.04),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h * 0.04),

            // Input box
            TextField(
              controller: queryController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "e.g. Suggest a smartwatch under 5000৳",
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: listTileColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
            ),
            SizedBox(height: h * 0.03),

            // Button
            ElevatedButton(
              onPressed: () {
              
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("AI is thinking...")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.1, vertical: h * 0.015),
                child: Text("Ask AI", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
