import 'package:cattle_track/model_objects/home_button.dart';
import 'package:cattle_track/screens/cattle_manager_screen.dart';
import 'package:cattle_track/screens/cattle_reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    double iconSize = screenWidth < 600 ? screenWidth * 0.3 : screenWidth * 0.1;
    double buttonTextSize =
        screenWidth < 600 ? screenHeight * 0.002 : screenHeight * 0.0035;
    double titleSize =
        screenWidth < 600 ? screenWidth * 0.003 : screenWidth * 0.002;

    final List<HomeButton> buttonsList = [
      HomeButton(
          name: "Cattle",
          iconWidget: SvgPicture.asset(
            'icons/cattle_icon.svg',
            height: iconSize,
          ),
          widget: const CattleManagerScreen()),
      HomeButton(
        name: "Reports",
        iconWidget: SvgPicture.asset(
          'icons/reports_icon.svg',
          height: iconSize,
        ),
        widget: const CattleReports(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.09,
        title: Text(
          "Cattle Track",
          textScaler: TextScaler.linear(titleSize),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: screenWidth,
                      crossAxisSpacing: 16,
                      mainAxisExtent: screenHeight > 600
                          ? screenHeight / 2.5
                          : screenHeight / 3,
                      mainAxisSpacing: 16),
                  itemCount: buttonsList.length,
                  itemBuilder: (context, index) {
                    HomeButton getButton = buttonsList.elementAt(index);

                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => getButton.widget));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getButton.iconWidget,
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              getButton.name,
                              textScaler: TextScaler.linear(buttonTextSize),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
