import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF005FAF), Color(0xFF003C71)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.08),
                  _buildLogo(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.04),
                  _buildWelcomeText(screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  _buildTextField(
                    controller: controller.cEmail,
                    label: "Email",
                    icon: Icons.email_outlined,
                    screenHeight: screenHeight,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  _buildTextField(
                    controller: controller.cPass,
                    label: "Password",
                    icon: Icons.lock_outline,
                    screenHeight: screenHeight,
                    obscureText: true,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  _buildLoginButton(screenHeight, screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildFooterLinks(screenHeight),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.5,
      height: screenHeight * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          "assets/images/bri.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildWelcomeText(double screenHeight) {
    return Column(
      children: [
        Text(
          "Selamat Datang",
          style: TextStyle(
            fontSize: screenHeight * 0.034,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "ADM BRI Link",
          style: TextStyle(
            fontSize: screenHeight * 0.02,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required double screenHeight,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: screenHeight * 0.018,
        ),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF005FAF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(double screenHeight, double screenWidth) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.062,
      child: ElevatedButton(
        onPressed: () {
          cAuth.login(controller.cEmail.text, controller.cPass.text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFBB040),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: screenHeight * 0.02,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLinks(double screenHeight) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Get.offAllNamed(Routes.RESET_PASSWORD);
            },
            child: Text(
              "Reset Password",
              style: TextStyle(
                fontSize: screenHeight * 0.016,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Belum punya akun?",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.016,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.offAllNamed(Routes.SIGNUP);
              },
              child: Text(
                "Daftar Disini",
                style: TextStyle(
                  color: Color(0xFFFBB040),
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.016,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
