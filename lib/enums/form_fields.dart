import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FormFields {
  name("Name"),
  naabCode("NAAB Code"),
  gender("Gender"),
  birthWeight("Birth Weight", TextInputType.number, "${r'^\d+\.?\d{0,2}'}"),
  birthDate("Birth Date", TextInputType.datetime),
  sireName("Sire Name"),
  notes("Notes");

  const FormFields(this.label, [this.keyboardType, this.inputFormatter]);

  final String label;
  final TextInputType? keyboardType;
  final String? inputFormatter;
}
