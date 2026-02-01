import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:locked_in/core/router/app_router.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              context.router.push(MainShellRoute());
            },
            child: Text(
              'SKIP',
              style: GoogleFonts.inter(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome back',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your details to sync your progress.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 48),
            _buildTextField(
              hint: 'Email address',
              icon: IconsaxPlusLinear.sms,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              hint: 'Password',
              icon: IconsaxPlusLinear.lock,
              isPassword: true,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => context.router.replaceNamed('/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'LOG IN',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: Colors.black54),
          hintText: hint,
          hintStyle: GoogleFonts.inter(color: Colors.black38),
        ),
      ),
    );
  }
}
