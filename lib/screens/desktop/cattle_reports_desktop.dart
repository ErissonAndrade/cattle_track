import 'package:cattle_track/charts/pie_chart.dart';
import 'package:cattle_track/enums/cattle_classification.dart';
import 'package:cattle_track/model_objects/cattle.dart';
import 'package:cattle_track/providers/cattle_provider.dart';
import 'package:cattle_track/widgets/cards/cattle_quantity_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CattleReportsDesktop extends StatelessWidget {
  const CattleReportsDesktop({super.key});

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

    double screenHeigth = MediaQuery.sizeOf(context).height;

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Reports"),
        ),
        body: cattleList.isEmpty
            ? const Center(child: Text("No cattle added yet!"))
            : Row(
                children: [
                  Flexible(
                    child: ListView.builder(
                        itemCount: classificationsList.length,
                        itemExtent:
                            screenHeigth / classificationsList.length - 20,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            child: CattleQuantityCard(
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
                                    .iconPath),
                          );
                        }),
                  ),
                  const Expanded(flex: 3, child: PieChartWithImages())
                ],
              ));
  }
}
