import 'package:cattle_track/enums/cattle_classification.dart';
import 'package:cattle_track/model_objects/cattle.dart';
import 'package:cattle_track/providers/cattle_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PieChartWithImages extends StatefulWidget {
  const PieChartWithImages({super.key});

  @override
  State<StatefulWidget> createState() => PieChartWithImagesState();
}

class PieChartWithImagesState extends State<PieChartWithImages> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 0,
        sections: showingSections(),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<Cattle> cattleList = context.watch<CattleProvider>().cattleList;

    int totalCattle = cattleList.length;
    if (totalCattle == 0) {
      return [];
    }

    int calfCount = cattleList
        .where((cattle) =>
            cattle.classification == CattleClassification.calf.classification)
        .length;
    int bullCount = cattleList
        .where((cattle) =>
            cattle.classification == CattleClassification.bull.classification)
        .length;
    int cowCount = cattleList
        .where((cattle) =>
            cattle.classification == CattleClassification.cow.classification)
        .length;

    double calfPercentage = (calfCount / totalCattle) * 100;
    double bullPercentage = (bullCount / totalCattle) * 100;
    double cowPercentage = (cowCount / totalCattle) * 100;

    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double radius =
        screenWidth > 600 ? screenWidth * 0.15 : screenWidth * 0.36;
    final fontSize =
        screenWidth > 600 ? screenWidth * 0.026 : screenWidth * 0.05;
    final widgetSize =
        screenWidth > 600 ? screenWidth * 0.06 : screenWidth * 0.15;

    return List.generate(cattleList.length, (i) {
      final isTouched = i == touchedIndex;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: calfPercentage,
            radius: isTouched ? radius * 1.2 : radius,
            title: '${calfPercentage.toStringAsFixed(1)}%',
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              CattleClassification.calf.iconPath,
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue,
            value: bullPercentage,
            title: '${bullPercentage.toStringAsFixed(1)}%',
            radius: isTouched ? radius * 1.2 : radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              CattleClassification.bull.iconPath,
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.yellow,
            value: cowPercentage,
            title: '${cowPercentage.toStringAsFixed(1)}%',
            radius: isTouched ? radius * 1.2 : radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              CattleClassification.cow.iconPath,
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception("Failed to generate chart.");
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
        ),
      ),
    );
  }
}
