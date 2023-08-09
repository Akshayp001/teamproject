import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teamproject/Models/InventoryModel.dart';
import 'package:teamproject/Services/InventoryProvider.dart';
import 'package:teamproject/Services/data.dart';

import '../others/constants.dart';

class MyBottomSheet extends StatefulWidget {
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  // List<InventoryItem> givenItems = Dataitems;
  bool _isGive = false;
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final _borrowerNameController = TextEditingController();
  final _issuerNameController = TextEditingController();
  final _objectController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _borrowerNameController.dispose();
    _issuerNameController.dispose();
    _objectController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.amber;
        }
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.amber.withOpacity(0.54);
        }
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade400;
        }
        return null;
      },
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Borrowing Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _teamNameController,
                decoration: InputDecoration(
                  hintText: 'Team Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(Icons.people),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a team name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _borrowerNameController,
                decoration: InputDecoration(
                  hintText: 'Borrower Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a borrower name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _issuerNameController,
                decoration: InputDecoration(
                  hintText: 'Issuer Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an issuer name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: TextEditingController(
                      text: _selectedDate == null
                          ? ''
                          : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Borrowing Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey[400]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a borrowing date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _objectController,
                decoration: InputDecoration(
                  hintText: 'Object Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(Icons.category),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an object name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (value.length != 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "GIVE",
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  // Switch(
                  //value: true, onChanged: (value){})
                  Switch(
                      value: _isGive,
                      onChanged: (value) {
                        setState(() {
                          _isGive = value;
                        });
                      }),
                  const Text(
                    "TAKE",
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // context.read<InventoryProvider>().addItem(InventoryItem(
                    //     MobNoOfTaker: _phoneNumberController.text,
                    //     ObjectName: _objectController.text,
                    //     borrowedDateTime: _selectedDate!.toString(),
                    //     id: DateTime.now().toString(),
                    //     isGiven: !_isGive,
                    //     isTaken: _isGive,
                    //     nameOfOtherPerson: _borrowerNameController.text,
                    //     nameOfPersonFromTeam: _issuerNameController.text,
                    //     teamName: _teamNameController.text,
                    //     isReturned: false,
                    //     returnedDateTime: null));
                    FirebaseFirestore.instance
                        .collection(INVENTORY_ITEMS_COLLECTION)
                        .add({
                      'id': '',
                      'isGiven': !_isGive,
                      'isTaken': _isGive,
                      'teamName': _teamNameController.text.trim(),
                      'MobNoOfTaker': _phoneNumberController.text.trim(),
                      'ObjectName': _objectController.text.trim(),
                      'IssuerName': _issuerNameController.text,
                      'BorrowerName': _borrowerNameController.text,
                      'borrowedDateTime':
                          DateFormat.yMEd().format(_selectedDate!).toString(),
                      'returnedDateTime': '',
                      'isReturned': false,
                      'timeStamp': Timestamp.now(),
                    }).then((value) => inventoryColRef.doc(value.id).update({
                              'id': value.id,
                            }));
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
