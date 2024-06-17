import 'package:cattle_track/model_objects/cattle.dart';
import 'package:flutter/foundation.dart';

class CattleProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final List<Cattle> _cattleList = [];

  List<Cattle> get cattleList => _cattleList;

  void addCattle(Cattle newCattle) {
    _cattleList.add(newCattle);
    notifyListeners();
  }

  void removeCattle(Cattle cattleToRemove) {
    _cattleList.remove(cattleToRemove);
    notifyListeners();
  }

  void updateCattle(int cattleId, Cattle cattleToUpdate) {
    int index = _cattleList.indexWhere((cattle) => cattle.id == cattleId);

    if (index != -1) {
      _cattleList[index] = cattleToUpdate;
    }

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('cattleList', cattleList));
  }
}
