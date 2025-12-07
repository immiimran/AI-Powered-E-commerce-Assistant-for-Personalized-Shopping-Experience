import 'package:flutter/material.dart';
import '../../const/colors.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor.withOpacity(0.2),
              child: Icon(Icons.person, size: 55, color: primaryColor),
            ),
            SizedBox(height: 12),

            Text(
              "Imran Immi",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Flutter Developer", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),

            // Buttons
            _menuItem(Icons.person, "Edit Profile"),
            _menuItem(Icons.settings, "Settings"),
            _menuItem(Icons.lock, "Change Password"),
            _menuItem(Icons.notifications, "Notifications"),
            _menuItem(Icons.logout, "Logout", isRed: true),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, {bool isRed = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: isRed ? Colors.red : primaryColor),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: isRed ? Colors.red : Colors.black87,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
