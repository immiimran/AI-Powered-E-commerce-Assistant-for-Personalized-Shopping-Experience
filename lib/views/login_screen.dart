import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../const/colors.dart';
import '../routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.08, vertical: h * 0.12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back 👋",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                "Login to your Smart Shop account",
                style: TextStyle(color: Colors.white70, fontSize: w * 0.04),
              ),
              SizedBox(height: h * 0.08),

              // Email Field
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),

              // Password Field
              TextField(
                controller: passController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: h * 0.05),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: h * 0.065,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    AuthController.instance.login(
                      emailController.text.trim(),
                      passController.text.trim(),
                    );
                  },
                  child: Text("Login", style: TextStyle(fontSize: w * 0.045, color: Colors.white)),
                ),
              ),
              SizedBox(height: h * 0.03),

              // Register Navigation
              Center(
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.register),
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(color: secondaryColor, fontSize: w * 0.04),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
