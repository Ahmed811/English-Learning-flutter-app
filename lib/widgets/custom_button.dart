import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final String iconName;
  final screen;
  const CustomButton({
    super.key,
    required this.buttonTitle,
    required this.iconName,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Card(
        child: Container(
          child: Column(
            children: [
              Lottie.asset("assets/lottie_icons/$iconName", height: 100),
              Text(
                buttonTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "bahja",
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
