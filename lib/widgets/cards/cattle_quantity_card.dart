import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CattleQuantityCard extends StatelessWidget {
  final String cattleClassification;
  final int quantity;
  final Color backgroundColor;
  final String iconPath;
  final double? height;

  const CattleQuantityCard(
      {super.key,
      required this.cattleClassification,
      required this.quantity,
      required this.backgroundColor,
      required this.iconPath,
      this.height});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double iconHeight =
        screenWidth > 600 ? screenWidth * 0.08 : screenWidth * 0.13;
    final double classificationFontSize =
        screenWidth > 600 ? screenWidth * 0.02 : screenWidth * 0.04;
    final double quantityFontSize =
        screenWidth > 600 ? screenWidth * 0.03 : screenWidth * 0.06;

    return Card(
        elevation: 5,
        color: backgroundColor,
        shadowColor: Colors.amber,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(10, 30))),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                height: iconHeight,
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cattleClassification,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: classificationFontSize,
                    ),
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(
                      fontSize: quantityFontSize,
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
