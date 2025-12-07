import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ai_controller.dart';
import '../const/colors.dart';

class AIResultPage extends StatelessWidget {
  AIResultPage({super.key});

  final AIController aiController = Get.find<AIController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Recommendation"),
        backgroundColor: primaryColor,
      ),
      body: Obx(() {
        if (aiController.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: primaryColor));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              aiController.aiResponse.value.isEmpty
                  ? "No recommendation yet."
                  : aiController.aiResponse.value,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        );
      }),
      backgroundColor: bgColor,
    );
  }
}
