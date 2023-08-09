import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teamproject/Models/InventoryModel.dart';
import 'package:teamproject/others/constants.dart';

class InventoryProvider extends ChangeNotifier {
  final _inventoryColRef =
      FirebaseFirestore.instance.collection(INVENTORY_ITEMS_COLLECTION);
  List<InventoryItem> _items = [];
  getInvList() async {
    QuerySnapshot queryData = await _inventoryColRef.get();
    List<InventoryItem> data = queryData.docs
        .map((e) => InventoryItem(
            id: e.id,
            isGiven: e['isGiven'],
            isTaken: e['isTaken'],
            isReturned: e['isReturned'],
            MobNoOfTaker: e['MobNoOfTaker'],
            ObjectName: e['ObjectName'],
            borrowedDateTime: e['borrowedDateTime'],
            nameOfOtherPerson: e['nameOfOtherPerson'],
            nameOfPersonFromTeam: e['nameOfPersonFromTeam'],
            teamName: e['teamName']))
        .toList();
    // return data;
    _items = data;
    print("okkkkkkk: " + data.length.toString());
    notifyListeners();
  }

  List<InventoryItem> get items => _items;
  // List<InventoryItem> get items => getInvList();

  set items(List<InventoryItem> value) {
    _items = value;
    notifyListeners();
  }

  

  void setReturnedDate(String? date, String id,bool isReturned) {
    // _items.firstWhere((element) => element.id == id).returnedDateTime = date;
    _inventoryColRef.doc(id).update({
      'returnedDateTime': date,
      'isReturned': isReturned,
    });
    ChangeNotifier();
  }

  void addItem(InventoryItem item) {
    _items.add(item);
    _inventoryColRef.add({
      'id': item.id,
      'isGiven': item.isGiven,
      'isTaken': item.isTaken,
      'teamName': item.teamName,
      'MobNoOfTaker': item.MobNoOfTaker,
      'ObjectName': item.ObjectName,
      'IssuerName': item.nameOfPersonFromTeam,
      'BorrowerName': item.nameOfOtherPerson,
      'borrowedDateTime': item.borrowedDateTime.toString(),
      'returnedDateTime': item.returnedDateTime?.toString(),
      'isReturned': item.isReturned,
      'timeStamp': Timestamp.now(),
    }).then((value) => _inventoryColRef.doc(value.id).update({
      'id': value.id,
    }));
    notifyListeners();
  }

  void removeItem(String id) {
    _inventoryColRef.doc(id.toString()).delete();
    // _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
