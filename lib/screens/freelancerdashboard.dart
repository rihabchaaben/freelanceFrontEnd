import 'package:flutter/material.dart';
import 'package:freelance/style/colors.dart';
import 'package:freelance/style/style.dart';
import 'package:freelance/style/text.dart';

class Freelancerdashboard extends StatefulWidget {
  const Freelancerdashboard({Key? key}) : super(key: key);

  @override
  State<Freelancerdashboard> createState() => _FreelancerdashboardState();
}

class _FreelancerdashboardState extends State<Freelancerdashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              welcomeTitle,
              style: titleStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 60.0,
                bottom: 40.0,
                left: 30.0,
                right: 30.0,
              ),
              child: Text(
                welcomeDescription,
                style: descriptionStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
