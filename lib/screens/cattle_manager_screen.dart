import 'package:cattle_track/model_objects/cattle.dart';
import 'package:cattle_track/model_objects/cattle_menu_item.dart';
import 'package:cattle_track/providers/cattle_provider.dart';
import 'package:cattle_track/screens/cattle_form.dart';
import 'package:cattle_track/widgets/cattle_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CattleManagerScreen extends StatelessWidget {
  const CattleManagerScreen({super.key});

  void _showDeleteConfirmationDialog(BuildContext context, Cattle cattle) {
    var cattleProvider = context.read<CattleProvider>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete this?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                cattleProvider.removeCattle(cattle);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addCattle(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CattleForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Cattle> cattleList = context.watch<CattleProvider>().cattleList;

    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double iconWidth =
        screenWidth < 600 ? screenWidth * 0.07 : screenWidth * 0.15;
    final double listTileFontSize =
        screenWidth < 600 ? screenWidth * 0.0016 : screenWidth * 0.0013;
    final double iconPopupMenuSize =
        screenWidth < 600 ? screenWidth * 0.04 : screenWidth * 0.03;

    return Scaffold(
        appBar: AppBar(
            title: const Text("Cattle"),
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        floatingActionButton: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown, iconColor: Colors.white),
          icon: const Icon(Icons.add),
          label: const Text(
            "Add",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _addCattle(context);
          },
        ),
        body: SafeArea(
          child: cattleList.isEmpty
              ? const Center(child: Text("No cattle added yet."))
              : ListView.builder(
                  itemCount: cattleList.length,
                  itemBuilder: (context, index) {
                    Cattle getCattle = cattleList.elementAt(index);

                    final List<CattleMenuItem> cattleMenuList = [
                      CattleMenuItem(
                          value: "View Records",
                          title: "View Records",
                          page: const Placeholder()),
                      CattleMenuItem(
                          value: "Edit Cattle",
                          title: "Edit Cattle",
                          page: CattleForm.update(getCattle)),
                    ];

                    return ListTile(
                      leading: SizedBox(
                          width: iconWidth,
                          child: getCattle.classificationWidgetIcon),
                      contentPadding: const EdgeInsets.all(16),
                      title: Row(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("NAAB Code: ${getCattle.naabCode}",
                                      textScaler:
                                          TextScaler.linear(listTileFontSize)),
                                  Text("Name: ${getCattle.name}",
                                      textScaler:
                                          TextScaler.linear(listTileFontSize)),
                                  Text("Sire name: ${getCattle.sireName}",
                                      textScaler:
                                          TextScaler.linear(listTileFontSize)),
                                  Text("Age: ${getCattle.age}",
                                      textScaler:
                                          TextScaler.linear(listTileFontSize)),
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Wrap(
                                    alignment: WrapAlignment.center,
                                    direction: Axis.vertical,
                                    spacing: 10,
                                    children: [
                                      Text(getCattle.classification,
                                          textScaler: TextScaler.linear(
                                              listTileFontSize)),
                                      Text(getCattle.gender,
                                          textScaler: TextScaler.linear(
                                              listTileFontSize)),
                                    ]),
                                Wrap(children: [
                                  CattlePopupMenu(
                                      cattleMenuList: cattleMenuList,
                                      iconSize: iconPopupMenuSize),
                                  IconButton(
                                    onPressed: () =>
                                        _showDeleteConfirmationDialog(
                                            context, getCattle),
                                    icon: Icon(Icons.delete,
                                        size: iconPopupMenuSize),
                                  )
                                ])
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
        ));
  }
}
