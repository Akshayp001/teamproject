import 'dart:ffi';

import 'package:flutter/material.dart';

class InventoryItem {
  String id;
  bool isGiven;
  bool isTaken;
  String teamName; //showing
  String MobNoOfTaker;
  String ObjectName; //showing
  String nameOfPersonFromTeam;
  String nameOfOtherPerson;
  String borrowedDateTime; //showing
  String? returnedDateTime;
  bool isReturned;

  InventoryItem(
      {required this.id,
      required this.isGiven,
      required this.isTaken,
      required this.isReturned,
      required this.MobNoOfTaker,
      required this.ObjectName,
      required this.borrowedDateTime,
      required this.nameOfOtherPerson,
      required this.nameOfPersonFromTeam,
      this.returnedDateTime,
      required this.teamName});
}
