import 'package:cattle_track/model_objects/home_button.dart';
import 'package:cattle_track/screens/desktop/cattle_manager_screen_desktop.dart';
import 'package:cattle_track/screens/desktop/cattle_reports_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    double iconSize = screenWidth * 0.1;
    double buttonTextSize = screenHeight * 0.0035;
    double titleSize = screenWidth * 0.002;

    final List<HomeButton> buttonsList = [
      HomeButton(
          name: "Cattle",
          iconWidget: SvgPicture.asset(
            'assets/icons/cattle_icon.svg',
            height: iconSize,
          ),
          widget: const CattleManagerScreenDesktop()),
      HomeButton(
        name: "Reports",
        iconWidget: SvgPicture.asset(
          'assets/icons/reports_icon.svg',
          height: iconSize,
        ),
        widget: const CattleReportsDesktop(),
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
                      mainAxisExtent: screenHeight / 3,
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
