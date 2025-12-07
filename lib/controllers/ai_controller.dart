import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AIController extends GetxController {
  var isLoading = false.obs;
  var aiResponse = "".obs;

  final String apiKey = "YOUR_OPENAI_API_KEY";

  // Fetch products from Firestore
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("products").get();

    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // AI Recommendation Logic
  Future<void> getAIRecommendation(String query) async {
    isLoading.value = true;

    List<Map<String, dynamic>> products = await fetchProducts();
    String productData = jsonEncode(products);

    final url = Uri.parse("");

    final body = {
      "model": "gpt-4o-mini",
      "messages": [
        {
          "role": "system",
          "content":
              "You are a product recommendation AI. Recommend products based on user query using this dataset: $productData"
        },
        {"role": "user", "content": query}
      ]
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey"
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      aiResponse.value =
          jsonDecode(response.body)["choices"][0]["message"]["content"];
    } else {
      aiResponse.value = "Error: ${response.body}";
    }

    isLoading.value = false;
  }
}
