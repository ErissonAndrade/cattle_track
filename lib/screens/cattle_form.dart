import 'package:cattle_track/enums/cattle_form_fields.dart';
import 'package:cattle_track/model_objects/cattle.dart';
import 'package:cattle_track/providers/cattle_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CattleForm extends StatefulWidget {
  final Cattle? cattleToUpdate;

  const CattleForm({super.key}) : cattleToUpdate = null;

  const CattleForm.update(this.cattleToUpdate, {super.key});

  @override
  State<CattleForm> createState() => _CattleFormState();
}

enum CattleGender {
    male('Male', 'male'),
    female('Female', 'female');

    const CattleGender(this.label, this.gender);
    final String label;
    final String gender;
}

class _CattleFormState extends State<CattleForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<CattleFormFields, TextEditingController> _mapFieldsToController =  {
    CattleFormFields.cattleName: TextEditingController(),
    CattleFormFields.naabCode: TextEditingController(),
    CattleFormFields.gender: TextEditingController(),
    CattleFormFields.birthWeight: TextEditingController(),
    CattleFormFields.birthDate: TextEditingController(),
    CattleFormFields.sireName: TextEditingController(),
    CattleFormFields.notes: TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    if (widget.cattleToUpdate != null) {
      String birthDateFormatted = DateFormat('MM/dd/yyyy').format(widget.cattleToUpdate!.birthDate);

      _mapFieldsToController[CattleFormFields.cattleName]!.text = widget.cattleToUpdate!.name;
      _mapFieldsToController[CattleFormFields.naabCode]!.text = widget.cattleToUpdate!.naabCode;
      _mapFieldsToController[CattleFormFields.gender]!.text = widget.cattleToUpdate!.gender;
      _mapFieldsToController[CattleFormFields.birthWeight]!.text = widget.cattleToUpdate!.birthWeight.toString();
      _mapFieldsToController[CattleFormFields.birthDate]!.text = birthDateFormatted;
      _mapFieldsToController[CattleFormFields.sireName]!.text = widget.cattleToUpdate!.sireName;
      _mapFieldsToController[CattleFormFields.notes]!.text = widget.cattleToUpdate!.notes;
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in _mapFieldsToController.values) {
      controller.dispose();
    }
  }

  InputDecoration _setInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
      )
    );
  }

  String? _validators(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return "Please enter a value";
    }

    if (fieldName == "NAAB Code") {
      List<Cattle> cattleList = context.read<CattleProvider>().cattleList;
      String naabCodeMessage = "NAAB Code already exists, please use another.";
      
      if (widget.cattleToUpdate == null) {
        if (cattleList.any((cattle) => cattle.naabCode == value)) {
          return naabCodeMessage;
        }
      } else {
        if (cattleList.any((cattle) =>
            cattle.naabCode == value && cattle.id != widget.cattleToUpdate!.id)) {
          return naabCodeMessage;
        }
      }
    }

    return null;
    
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime firstDate = DateTime.utc(1980);
    DateTime lastDate = DateTime.now();

    String firstDateWithoutHours = DateFormat('MM/dd/yyyy').format(firstDate);
    String lastDateWithoutHours = DateFormat('MM/dd/yyyy').format(lastDate);

    String errorFormatMessage = "Please enter the date in the following format: mm/dd/yyyy";

    String errorInvalidMessage = "The date must not be lower than $firstDateWithoutHours or higher than $lastDateWithoutHours";

    final DateTime? picked = await showDatePicker(
      context: context, 
      firstDate: firstDate, 
      lastDate: lastDate,
      errorFormatText: errorFormatMessage,
      errorInvalidText: errorInvalidMessage,
    );

    if(picked != null) {
      String pickedDateFormated = DateFormat('MM/dd/yyyy').format(picked);
     _mapFieldsToController[CattleFormFields.birthDate]!.text = pickedDateFormated;
    }
  }

  void _saveCattle() {
    if (_formKey.currentState!.validate()) {
      DateTime? birthDate;
      String birthDateString = _mapFieldsToController[CattleFormFields.birthDate]!.text;
      
      try {
        birthDate = DateFormat('MM/dd/yyyy').parse(birthDateString);
      } catch (e) {
        birthDate = null;
      }

      Cattle cattleData = Cattle(
        name: _mapFieldsToController[CattleFormFields.cattleName]!.text,
        naabCode: _mapFieldsToController[CattleFormFields.naabCode]!.text,
        gender: _mapFieldsToController[CattleFormFields.gender]!.text,
        birthWeight: double.tryParse(_mapFieldsToController[CattleFormFields.birthWeight]!.text) ?? 0.0,
        birthDate: birthDate!,
        sireName: _mapFieldsToController[CattleFormFields.sireName]!.text,
        notes: _mapFieldsToController[CattleFormFields.notes]!.text,
      );

      if (widget.cattleToUpdate != null) {
        context
            .read<CattleProvider>()
            .updateCattle(widget.cattleToUpdate!.id, cattleData);
      } else {
        context.read<CattleProvider>().addCattle(cattleData);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "${cattleData.name} successfully ${widget.cattleToUpdate != null ? 'updated' : 'added'}!")),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cattleToUpdate == null ? "Add cattle" : "Update Cattle"),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          ElevatedButton.icon(
              onPressed: _saveCattle, 
              label: Text(widget.cattleToUpdate == null ? "Add cattle" : "Update Cattle")
          )
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: _mapFieldsToController.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    CattleFormFields getField = _mapFieldsToController.keys.elementAt(index);
                    TextEditingController getController = _mapFieldsToController.values.elementAt(index);
                        switch(getField) {
                          case(CattleFormFields.gender): {
                            return DropdownMenu<CattleGender>(
                              initialSelection: CattleGender.male,
                              label: Text(CattleFormFields.gender.label),
                              controller: getController,                               
                              dropdownMenuEntries: CattleGender.values
                              .map<DropdownMenuEntry<CattleGender>>(
                                (CattleGender gender) {
                                  return DropdownMenuEntry<CattleGender>(
                                    value: gender,
                                    label: gender.label,
                                  );
                              }).toList(),
                            );
                          }
                
                          case(CattleFormFields.birthDate): {
                            return TextFormField(
                                readOnly: true ,
                                onTap: () => _selectDate(context),
                                validator: (value) => _validators(value, fieldName: CattleFormFields.birthDate.label),
                                decoration: _setInputDecoration(CattleFormFields.birthDate.label),
                                controller: getController,
                            );
                          }
                
                          case(CattleFormFields.birthWeight): {
                            return TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                    ),
                                ],
                                keyboardType: CattleFormFields.birthWeight.keyboardType,
                                validator: (value) => _validators(value, fieldName: CattleFormFields.birthWeight.label),
                                decoration: _setInputDecoration(CattleFormFields.birthWeight.label),
                                controller: getController,
                            );
                          }
                
                          case(CattleFormFields.notes): {
                            return TextFormField(
                                maxLines: 10,
                                minLines: 5,
                                validator: (value) => _validators(value, fieldName: CattleFormFields.notes.label),
                                decoration: _setInputDecoration(CattleFormFields.notes.label),
                                controller: getController,
                            );
                          }
                
                          default: {
                            return TextFormField(
                                validator: (value) => _validators(value, fieldName: getField.label),
                                decoration: _setInputDecoration(getField.label),
                                controller: getController,
                            );
                          }
                        }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
