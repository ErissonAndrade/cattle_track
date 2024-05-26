import 'package:cattle_track/model_objects/home_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cattle Track',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Cattle Track'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<HomeButton> buttonsList = [
    HomeButton(
      name: "Cattle",
      icon: Icons.pets, 
      widget: const Placeholder()
    ),
    HomeButton(
        name: "Milk Diary",
        icon: Icons.water_drop_rounded,
        widget: const Placeholder()
    ),
    HomeButton(
        name: "Reports",
        icon: Icons.auto_graph_outlined,
        widget: const Placeholder()
    ),
    HomeButton(
        name: "Connect Device",
        icon: Icons.bluetooth,
        widget: const Placeholder()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    double iconSize = screenHeight > 600 ? screenWidth * 0.1 : screenWidth * 0.08;
    double buttonTextSize = screenWidth > 600 ? screenHeight * 0.003 : screenHeight * 0.002;
    double titleSize =screenWidth > 600 ? screenWidth * 0.002 : screenWidth * 0.003;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.09,
        title: Text(
          widget.title,
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
                      maxCrossAxisExtent: screenWidth / 2,
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
                            Icon(
                              getButton.icon,
                              size: iconSize,
                            ),
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
