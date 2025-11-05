import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../const/colors.dart';
import '../routes/app_routes.dart';

class RegisterScreen extends StatelessWidget {
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
                "Create Account ✨",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                "Sign up to start shopping with Smart Shop",
                style: TextStyle(color: Colors.white70, fontSize: w * 0.04),
              ),
              SizedBox(height: h * 0.08),

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
                    AuthController.instance.register(
                      emailController.text.trim(),
                      passController.text.trim(),
                    );
                  },
                  child: Text("Sign Up", style: TextStyle(fontSize: w * 0.045, color: Colors.white)),
                ),
              ),
              SizedBox(height: h * 0.03),

              Center(
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.login),
                  child: Text(
                    "Already have an account? Login",
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
