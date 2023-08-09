import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:teamproject/Models/InventoryModel.dart';
import 'package:teamproject/Services/InventoryProvider.dart';

import '../others/constants.dart';

class ExListTile extends StatefulWidget {
  // InventoryItem itemInv;
  var itemId;
  ExListTile(this.itemId);

  @override
  State<ExListTile> createState() => _ExListTileState();
}

class _ExListTileState extends State<ExListTile> {
  bool isExpanded = false;
  bool isReturned = false;

  late InventoryItem itemInv;
  final CollectionReference _inventoryColRef =
      FirebaseFirestore.instance.collection(INVENTORY_ITEMS_COLLECTION);
  var ItemCol;
  var _id;

  @override
  void initState() {
    // TODO: implement initState
    // getItemStatus();
    ItemCol = Colors.amber;
  }

  double heightofTile = 100;
  @override
  Widget build(BuildContext context) {
    print("idOFITEM " + widget.itemId);
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: StreamBuilder<DocumentSnapshot>(
          stream: _inventoryColRef.doc(widget.itemId).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: SizedBox.shrink(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: SizedBox.shrink(),
              );
            }

            var data = snapshot.data
                ?.data(); // Access the actual data using the data() method

            if (data == null) {
              return const Center(
                child: SizedBox.shrink(),
              );
            }
            var col = snapshot.data!.exists
                ? (isExpanded
                    ? ((snapshot.data?["isReturned"])
                            ? Colors.lightGreen
                            : (snapshot.data?["isGiven"])
                                ? Colors.amber
                                : Colors.purple)
                        .shade300
                    : ((snapshot.data?["isReturned"])
                            ? Colors.lightGreen
                            : (snapshot.data?["isGiven"])
                                ? Colors.amber
                                : Colors.purple)
                        .shade700)
                : Colors.red;
            return AnimatedContainer(
              onEnd: () {},
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  color: col, borderRadius: BorderRadius.circular(12)),
              height: isExpanded ? 190 : 100,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // itemInv.ObjectName,

                                snapshot.data?['ObjectName'],

                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito'),
                              ),
                              Text(
                                // itemInv.teamName,

                                snapshot.data?['teamName'],
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Borrowed On:',
                                style: TextStyle(
                                    fontSize: 13,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito'),
                              ),
                              Text(
                                snapshot.data?['borrowedDateTime'],
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _inventoryColRef
                                            .doc(widget.itemId)
                                            .update({
                                          'returnedDateTime': DateFormat.yMEd()
                                              .format(DateTime.now())
                                              .toString(),
                                          'isReturned':
                                              !(snapshot.data?["isReturned"]),
                                        });
                                        (snapshot.data?["isReturned"])
                                            ? ItemCol = Colors.lightGreen
                                            : ItemCol = itemInv.isGiven
                                                ? Colors.amber
                                                : Colors.purple;
                                      });
                                    },
                                    child: Icon(
                                      (snapshot.data!.exists &&
                                              snapshot.data?["isReturned"])
                                          ? Icons.done_outline_rounded
                                          : Icons.circle_outlined,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    !isExpanded
                        ? const SizedBox(
                            height: 10,
                          )
                        : Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Borrower Name : ${snapshot.data?['BorrowerName']}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito'),
                                      ),
                                      Text(
                                        "Mob No. : ${snapshot.data?['MobNoOfTaker']}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito'),
                                      ),
                                      Text(
                                        "Issued By : ${snapshot.data?['IssuerName']}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito'),
                                      ),
                                      Text(snapshot.data?['isReturned']
                                          ? 'Return Date : ${snapshot.data?['returnedDateTime']}'
                                          : 'Return Date : NA'),
                                      Text((snapshot.data?["isReturned"])
                                          ? "Returned: Yes"
                                          : "Returned: No"),
                                    ]),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
