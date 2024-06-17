import 'package:cattle_track/enums/cattle_gender_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

enum CattleClassification {
  calf("Calf", "icons/calf_icon.svg", Colors.green),
  cow("Cow", "icons/cow_icon.svg", Colors.yellow),
  bull("Bull", "icons/bull_icon.svg", Colors.blue);

  static CattleClassification classify(DateTime birthDate, String gender) {
    Period timePeriod = _getPeriod(birthDate);
    int years = timePeriod.years;

    if (years >= 1 && gender == CattleGender.male.label) {
      return CattleClassification.bull;
    } else if (years >= 1 && gender == CattleGender.female.label) {
      return CattleClassification.cow;
    } else {
      return CattleClassification.calf;
    }
  }

  const CattleClassification(
      this.classification, this.iconPath, this.colorIdentification);

  final String classification;
  final String iconPath;
  final Color colorIdentification;

  static Period _getPeriod(DateTime birthDate) {
    LocalDateTime nowDate = LocalDateTime.now();
    LocalDateTime birthDateTime = LocalDateTime.dateTime(birthDate);

    Period period = nowDate.periodSince(birthDateTime);

    return period;
  }
}
