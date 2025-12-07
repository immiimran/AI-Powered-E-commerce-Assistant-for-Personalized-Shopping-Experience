import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const/colors.dart';
import '../../controllers/ai_controller.dart';

// ignore: use_key_in_widget_constructors
class AITab extends StatelessWidget {
  final TextEditingController queryController = TextEditingController();
  final AIController aiController = Get.put(AIController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Smart AI Assistants",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.06,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: h * 0.02),

            TextField(
              controller: queryController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText:
                    "Ask AI something... (e.g. Best smartwatch under 5000)",
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: listTileColor,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            SizedBox(height: h * 0.03),

            Obx(() => aiController.isLoading.value
                ? CircularProgressIndicator(color: primaryColor)
                : ElevatedButton(
                    onPressed: () {
                      aiController.getAIRecommendation(
                        queryController.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 0.1, vertical: h * 0.015),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:
                        Text("Ask AI", style: TextStyle(color: Colors.white)),
                  )),

            SizedBox(height: h * 0.03),

            // AI Response Box
            Obx(() => aiController.aiResponse.value.isEmpty
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: listTileColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor),
                    ),
                    child: Text(
                      aiController.aiResponse.value,
                      style: TextStyle(color: Colors.white, fontSize: w * 0.04),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
