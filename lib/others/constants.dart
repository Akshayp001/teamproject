import 'package:cloud_firestore/cloud_firestore.dart';

String INVENTORY_ITEMS_COLLECTION = 'InventoryItems';
String USERS_COLLECTION = 'Users';
String ATTENDENCE_COLLECTION = 'attendence';
  final inventoryColRef =
      FirebaseFirestore.instance.collection(INVENTORY_ITEMS_COLLECTION);





