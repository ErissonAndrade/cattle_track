import 'package:cattle_track/enums/cattle_gender_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CattleFormFields {
  cattleName(label: "Name"),
  naabCode(label:"NAAB Code"),
  gender(label: "Gender", dropDownMenuEntries: CattleGender.values),
  birthWeight(label:"Birth Weight", keyboardType: TextInputType.number, inputFormatter: r'^\d+\.?\d{0,2}'),
  birthDate(label:"Birth Date", keyboardType:TextInputType.datetime),
  sireName(label:"Sire Name"),
  notes(label:"Notes");

  const CattleFormFields({
    required this.label, 
    this.keyboardType, 
    this.inputFormatter,
    this.dropDownMenuEntries
  });

  final String label;
  final TextInputType? keyboardType;
  final String? inputFormatter;
  final List? dropDownMenuEntries;
}
