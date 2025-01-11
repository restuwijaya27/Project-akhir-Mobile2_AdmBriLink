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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF005FAF),
              Color(0xFF003C71),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.06),

                  // Logo Section
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/bri.jpg",
                          width: screenWidth * 0.7,
                          height: screenHeight * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Welcome Text
                  Text(
                    "Selamat Datang",
                    style: TextStyle(
                      fontSize: screenHeight * 0.034,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  Text(
                    "ADM Bri Link",
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Email Field
                  _buildTextField(
                    controller: controller.cEmail,
                    labelText: "Email",
                    icon: Icons.email_outlined,
                  ),

                  // Password Field
                  _buildTextField(
                    controller: controller.cPass,
                    labelText: "Password",
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      cAuth.login(controller.cEmail.text, controller.cPass.text);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      backgroundColor: const Color(0xFFFBB040),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.offAllNamed(Routes.RESET_PASSWORD),
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.016,
                        ),
                      ),
                    ),
                  ),

                  // Sign Up Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum Punya Akun ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.016,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.offAllNamed(Routes.SIGNUP),
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

                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Color(0xFF2D2D2D)),
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: Color(0xFF005FAF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}
