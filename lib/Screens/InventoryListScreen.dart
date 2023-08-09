import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teamproject/Models/InventoryModel.dart';
import 'package:teamproject/Widgets/exListTile.dart';
import 'package:teamproject/others/constants.dart';

import '../Services/InventoryProvider.dart';
import '../Widgets/BottomSheet.dart';

class InventoryListScreen extends StatelessWidget {
  String screenType;
  InventoryListScreen({super.key, required this.screenType});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var _stream;
    String title = 'Inventory';

    if (screenType == 'G') {
      title = 'Given Inventory';
      _stream = FirebaseFirestore.instance
          .collection(INVENTORY_ITEMS_COLLECTION)
          .orderBy('timeStamp', descending: true)
          .where('isGiven', isEqualTo: true)
          .snapshots();
    } else if (screenType == 'T') {
      title = 'Taken Inventory';
      _stream = FirebaseFirestore.instance
          .collection(INVENTORY_ITEMS_COLLECTION)
          .where('isTaken', isEqualTo: true)
          .orderBy('timeStamp', descending: true)
          .snapshots();
    } else if (screenType == 'NR') {
      title = 'Not Returned Inventory';
      _stream = FirebaseFirestore.instance
          .collection(INVENTORY_ITEMS_COLLECTION)
          .where('isReturned', isEqualTo: false)
          .orderBy('timeStamp', descending: true)
          .snapshots();
    } else if (screenType == 'R') {
      title = 'Returned Inventory';
      _stream = FirebaseFirestore.instance
          .collection(INVENTORY_ITEMS_COLLECTION)
          .where('isReturned', isEqualTo: true)
          .orderBy('timeStamp', descending: true)
          .snapshots();
    } else {
      _stream = FirebaseFirestore.instance
          .collection(INVENTORY_ITEMS_COLLECTION)
          .orderBy('timeStamp', descending: true)
          .snapshots();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return MyBottomSheet();
                });
          }),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w800),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined))
        // ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.length == 0) {
            return Center(
                child: Image(image: AssetImage('assets/image/noInvData.jpg')));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth / 35, vertical: screenWidth / 40),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          FirebaseFirestore.instance
                              .collection(INVENTORY_ITEMS_COLLECTION)
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        },
                        backgroundColor: Colors.red,
                        icon: FontAwesomeIcons.deleteLeft,
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(12)),
                        foregroundColor: Colors.black,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: ExListTile(snapshot.data!.docs[index].id ?? ''),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
