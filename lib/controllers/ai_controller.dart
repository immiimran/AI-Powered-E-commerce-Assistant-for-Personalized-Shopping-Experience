import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AIController extends GetxController {
  /// -------------------------------
  /// State
  /// -------------------------------
  RxBool isLoading = false.obs;
  RxString aiResponse = "".obs;

  /// -------------------------------
  /// API KEYS
  /// -------------------------------
 
  /// -------------------------------
  /// FETCH ALL PRODUCTS FROM FIRESTORE
  /// -------------------------------
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("products").get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  /// -------------------------------
  /// GPT PRODUCT RECOMMENDATION (Text Query)
  /// -------------------------------
  Future<void> getAIRecommendation(String query) async {
    try {
      isLoading.value = true;

      List<Map<String, dynamic>> products = await fetchProducts();
      String productData = jsonEncode(products);

      final url = Uri.parse("https://api.openai.com/v1/chat/completions");

      final body = {
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content":
                "You are a product recommendation AI. Recommend products ONLY from this dataset: $productData. Be concise and relevant."
          },
          {"role": "user", "content": query}
        ]
      };

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAIKey",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        aiResponse.value =
            jsonDecode(response.body)["choices"][0]["message"]["content"];
      } else {
        aiResponse.value = "Error: ${response.body}";
      }
    } catch (e) {
      aiResponse.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }

  /// -------------------------------
  /// GOOGLE VISION IMAGE ANALYSIS
  /// -------------------------------
  Future<String?> analyzeImage(File image) async {
    try {
      isLoading.value = true;

      final bytes = await image.readAsBytes();
      String base64Image = base64Encode(bytes);

      final url =
          "https://vision.googleapis.com/v1/images:annotate?key=$visionKey";

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "requests": [
            {
              "image": {"content": base64Image},
              "features": [
                {"type": "LABEL_DETECTION", "maxResults": 5}
              ]
            }
          ]
        }),
      );

      final data = jsonDecode(response.body);

      List labels = data["responses"][0]["labelAnnotations"] ?? [];

      if (labels.isEmpty) return null;

      String detectedObject = labels[0]["description"];
      return detectedObject;
    } catch (e) {
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// -------------------------------
  /// SEARCH PRODUCTS IN FIRESTORE (BY KEYWORD)
  /// -------------------------------
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("products")
          .where("keywords", arrayContains: query.toLowerCase())
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// -------------------------------
  /// FULL IMAGE SEARCH FLOW
  /// -------------------------------
  Future<void> getAIRecommendationByImage(File image) async {
    try {
      isLoading.value = true;

      // 1️⃣ Detect object from image
      String? detected = await analyzeImage(image);

      if (detected == null) {
        aiResponse.value = "No recognizable object detected.";
        return;
      }

      // 2️⃣ Search Firestore products using detected object
      List<Map<String, dynamic>> products = await searchProducts(detected);

      if (products.isEmpty) {
        aiResponse.value =
            "No products found matching '$detected'. Try another image or search.";
        return;
      }

      // 3️⃣ Create prompt for GPT
      String productData = jsonEncode(products);

      final url = Uri.parse("https://api.openai.com/v1/chat/completions");

      final body = {
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content":
                "You are a product recommendation AI. Recommend products ONLY from this dataset: $productData. Be concise and user-friendly."
          },
          {
            "role": "user",
            "content": "Recommend based on the detected object: $detected"
          }
        ]
      };

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAIKey",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        aiResponse.value =
            jsonDecode(response.body)["choices"][0]["message"]["content"];
      } else {
        aiResponse.value = "Error: ${response.body}";
      }
    } catch (e) {
      aiResponse.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
