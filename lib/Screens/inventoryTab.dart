import 'package:flutter/material.dart';
import 'package:teamproject/Screens/InventoryListScreen.dart';

import '../Widgets/BottomSheet.dart';

class InventoryTab extends StatelessWidget {
  const InventoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "INVENTORY",
            style: TextStyle(
              letterSpacing: 2,
              fontFamily: 'Nunito',
              color: Colors.amber.shade900,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(1, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
              child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return InventoryListScreen(screenType: 'A',);
                })),
                child: Container(
                  width: 420,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0x52E20808),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      'ALL INVENTORY',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return InventoryListScreen(screenType: 'G',);
                })),
                  child: Container(
                    width: 180,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0x6DD9C128),
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                    child: const Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'GIVEN\nINVENTORY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return InventoryListScreen(screenType: 'T',);
                })),
                  child: Container(
                    width: 180,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0x7A5F358E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'TAKEN\nINVENTORY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return InventoryListScreen(screenType: 'R',);
                })),
                  child: Container(
                    width: 180,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(108, 49, 217, 40),
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                    child: const Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'RETURNED\nINVENTORY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return InventoryListScreen(screenType: 'NR',);
                })),
                  child: Container(
                    width: 180,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(121, 255, 16, 16),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'NOT RETURNED\nINVENTORY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return MyBottomSheet();
                  });
            },
            child: Container(
              margin: EdgeInsets.all(10),
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(spreadRadius: 8, color: Colors.grey, blurRadius: 15)
                ],
                color: Colors.red.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Add Record",
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
