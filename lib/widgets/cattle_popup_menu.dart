import 'package:cattle_track/model_objects/cattle_menu_item.dart';
import 'package:flutter/material.dart';

class CattlePopupMenu extends StatelessWidget {
  final List<CattleMenuItem> cattleMenuList;
  final double? iconSize;

  const CattlePopupMenu({super.key, required this.cattleMenuList, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CattleMenuItem>(
      itemBuilder: (context) {
        return cattleMenuList.map((CattleMenuItem item) {
          return PopupMenuItem<CattleMenuItem>(
            value: item,
            child: Text(item.title),
          );
        }).toList();
      },
      onSelected: (CattleMenuItem item) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item.page),
        );
      },
      icon: Icon(Icons.more_vert, size: iconSize),
    );
  }
}
