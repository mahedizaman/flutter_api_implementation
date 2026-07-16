import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_json_placeholder_api/apis/user.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool startAnimation = false;
  @override
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        startAnimation = true;
      });
    });

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserApiPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 105, 21),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: startAnimation ? 1 : 0,
              duration: const Duration(seconds: 2),
              child: AnimatedScale(
                scale: startAnimation ? 1 : 0.4,
                duration: const Duration(seconds: 2),
                curve: Curves.easeOutBack,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Json',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 232, 249, 240),
                          fontSize: 52,
                          fontWeight: FontWeight(700),
                        ),
                      ),
                      TextSpan(
                        text: 'Placeholder.',
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 8, 53, 75),
                        ),
                      ),
                      TextSpan(
                        text: '\nAPI IMPLEMENTATION',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
