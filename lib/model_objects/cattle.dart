import 'package:cattle_track/enums/cattle_classification.dart';
import 'package:cattle_track/model_objects/cattle_health.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_machine/time_machine.dart';

class Cattle {
  static int _idCounter = 1;

  int id;
  String name;
  String naabCode;
  String gender;
  double birthWeight;
  DateTime birthDate;
  String sireName;
  String notes;
  String age;
  String classification;
  Widget classificationWidgetIcon;
  CattleHealth? cattleHealth;

  Cattle({
    required this.name,
    required this.naabCode,
    required this.gender,
    required this.birthWeight,
    required this.birthDate,
    required this.sireName,
    this.notes = '',
  }) : 
  id = _idCounter++,
  age = _getAge(birthDate),
  classification = CattleClassification.classify(birthDate, gender).classification,
  classificationWidgetIcon = SvgPicture.asset(CattleClassification.classify(birthDate, gender).iconPath);


  static String _getAge(DateTime birthDate) {
    LocalDateTime nowDate = LocalDateTime.now();
    LocalDateTime birthDateTime = LocalDateTime.dateTime(birthDate);

    Period getPeriod = nowDate.periodSince(birthDateTime);

    int getYears = getPeriod.years;
    int getMonths = getPeriod.months;
    int getDays = getPeriod.days;

    String ageInYearsMonthsDays = "$getYears years, $getMonths months and $getDays days";

    return ageInYearsMonthsDays;
  }

}
