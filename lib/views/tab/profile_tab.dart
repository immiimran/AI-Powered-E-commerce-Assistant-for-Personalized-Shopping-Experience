import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../const/colors.dart';

class ProfileTab extends StatelessWidget {
  final user = AuthController.instance.auth.currentUser;

   ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      color: bgColor,
      padding: EdgeInsets.all(w * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: h * 0.1),
          CircleAvatar(
            radius: w * 0.15,
            backgroundColor: secondaryColor,
            child: Icon(Icons.person, color: Colors.white, size: w * 0.15),
          ),
          SizedBox(height: h * 0.03),
          Text(user?.email ?? "Unknown User",
              style: TextStyle(color: Colors.white, fontSize: w * 0.045)),
          SizedBox(height: h * 0.05),
          ElevatedButton.icon(
            onPressed: () => AuthController.instance.logout(),
            icon: Icon(Icons.logout, color: Colors.white),
            label: Text("Logout", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(
                  horizontal: w * 0.1, vertical: h * 0.015),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
