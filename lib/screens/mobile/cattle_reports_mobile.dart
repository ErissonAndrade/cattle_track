import 'package:cattle_track/charts/pie_chart.dart';
import 'package:cattle_track/enums/cattle_classification.dart';
import 'package:cattle_track/model_objects/cattle.dart';
import 'package:cattle_track/providers/cattle_provider.dart';
import 'package:cattle_track/widgets/cards/cattle_quantity_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CattleReportsMobile extends StatelessWidget {
  const CattleReportsMobile({super.key});

  int getCattleQuantity(
      List<Cattle> cattleList, CattleClassification cattleClassification) {
    Iterable<Cattle> getCattleByClassification = cattleList.where((cattle) =>
        cattle.classification == cattleClassification.classification);
    int cattleQuantity = getCattleByClassification.length;

    return cattleQuantity;
  }

  @override
  Widget build(BuildContext context) {
    List<Cattle> cattleList = context.watch<CattleProvider>().cattleList;

    List<CattleClassification> classificationsList =
        CattleClassification.values;

    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Reports"),
        ),
        body: cattleList.isEmpty
            ? const Center(child: Text("No cattle added yet!"))
            : Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 16),
                        itemCount: classificationsList.length,
                        scrollDirection: Axis.horizontal,
                        itemExtent: screenWidth / classificationsList.length,
                        itemBuilder: (context, index) {
                          return CattleQuantityCard(
                              cattleClassification: classificationsList
                                  .elementAt(index)
                                  .classification,
                              quantity: getCattleQuantity(cattleList,
                                  classificationsList.elementAt(index)),
                              backgroundColor: classificationsList
                                  .elementAt(index)
                                  .colorIdentification,
                              iconPath: classificationsList
                                  .elementAt(index)
                                  .iconPath);
                        }),
                  ),
                  const Expanded(flex: 4, child: PieChartWithImages())
                ],
              ));
  }
}
