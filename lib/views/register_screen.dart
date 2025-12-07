import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/colors.dart';
import '../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscurePass = true;

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("fullName", fullNameController.text.trim());
    await prefs.setString("phone", phoneController.text.trim());
    await prefs.setString("email", emailController.text.trim());
    await prefs.setBool("isLoggedIn", true);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: w * 0.08, vertical: h * 0.12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/register.svg",
                    height: h * 0.25),
                SizedBox(height: h * 0.03),
                Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign up to start shopping with Smart Shop",
                  style: TextStyle(color: Colors.white70, fontSize: w * 0.04),
                ),
                SizedBox(height: h * 0.03),
                TextFormField(
                  controller: fullNameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Full Name",
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
                  validator: (value) =>
                      value!.isEmpty ? "Full name is required" : null,
                ),
                SizedBox(height: h * 0.02),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Phone Number",
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
                  validator: (value) =>
                      value!.isEmpty ? "Phone number is required" : null,
                ),
                SizedBox(height: h * 0.02),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  validator: (value) {
                    if (value!.isEmpty) return "Email is required";
                    if (!value.contains("@")) return "Enter a valid email";
                    return null;
                  },
                ),
                SizedBox(height: h * 0.02),
                TextFormField(
                  controller: passController,
                  obscureText: obscurePass,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePass ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePass = !obscurePass;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return "Password is required";
                    if (value.length < 6) {
                      return "Minimum 6 characters required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: h * 0.04),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await saveUserData();

                        Get.snackbar(
                          "Success",
                          "Sign Up Successfully",
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          backgroundColor: primaryColor,
                        );

                        Future.delayed(Duration(seconds: 1), () {
                          Get.offAllNamed(AppRoutes.home);
                        });
                      }
                    },
                    child: Text("Sign Up",
                        style: TextStyle(
                            fontSize: w * 0.045, color: Colors.white)),
                  ),
                ),
                SizedBox(height: h * 0.01),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.login),
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(color: secondaryColor, fontSize: w * 0.04),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
