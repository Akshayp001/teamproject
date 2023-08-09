import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamproject/Models/userModule.dart';
import 'package:teamproject/Screens/CalenderTab.dart';
import 'package:teamproject/Screens/TodoTab.dart';
import 'package:teamproject/Screens/attHomePage.dart';
import 'package:teamproject/Screens/inventoryTab.dart';
import 'package:teamproject/Widgets/mainDrawer.dart';

import '../Models/userMod.dart';
import '../Widgets/botNavBar.dart';

class Homepage extends StatefulWidget {
  UserOfApp? userData;

  Homepage({this.userData});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int currentIndex = 0;

  List<IconData> navIcons = [
    // FontAwesomeIcons.calendarDay,
    FontAwesomeIcons.home,
    FontAwesomeIcons.tasks,
    FontAwesomeIcons.toolbox,
  ];

  List<String> appbarNames = ['Home', 'Tasks', 'Inventory'];
  late List<records> listofRecs;

  getusers(String uid) async {
    QuerySnapshot<Map<String, dynamic>> tempUsers = await FirebaseFirestore
        .instance
        .collection('Users')
        .where('uid', isEqualTo: uid)
        .get();
    // return tempUsers.docs
    //     .map((e) =>
    //         records(name: e['name'], email: e['Email'], uid: e.id.toString()))
    //     .toList();
    mapRecords(tempUsers);
    // return tempp;
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> recs) {
    // return recs.docs
    var _list = recs.docs
        .map((e) => records(
            name: e['name'],
            email: e['Email'],
            uid: e.id.toString(),
            picurl: FirebaseAuth.instance.currentUser!.photoURL))
        .toList();
    setState(() {
      listofRecs = _list;
    });

    // print("Test 1 : " + listofRecs[0].uid.toString());
  }

  // getRecs() async {
  //   await getusers(FirebaseAuth.instance.currentUser!.uid);
  // }

  // getUsers() {
  //   getRecs();
  //   return listofRecs[0];
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listofRecs = [];
    getusers(FirebaseAuth.instance.currentUser!.uid);
    // pages = [
    //   CalenderTab(),
    //   AttHomePage(
    //     // keyFun: _key.currentState!.openDrawer,
    //     userData: listofRecs[0],
    //   ),
    //   toDoTab(),
    //   InventoryMainScreen(),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        extendBody: true,
        key: _key,
        drawer: MyDrawer(
            userEmail: widget.userData!.emailAd.toString(),
            userName: widget.userData!.name.toString(),
            userPicUrl: widget.userData!.picUrl.toString()),
        appBar: AppBar(
          title: Text(
            appbarNames[currentIndex],
            style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,

          // Sign out functionality

          actions: [
            IconButton(
                onPressed: () async {
                  await GoogleSignIn().signOut();
                  await FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.power_settings_new))
          ],
        ),

        //Signed in account showing

        // body: Container(
        //   width: double.infinity,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Text("Signed In As : ${userData?.emailAd}"),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       CircleAvatar(
        //         // minRadius: 20,
        //         backgroundImage: NetworkImage(userData!.picUrl.toString()),
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Text(userData!.name.toString()),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       ElevatedButton(
        //           onPressed: () {
        //             Navigator.of(context).push(MaterialPageRoute(
        //               builder: (context) => InventoryMainScreen(),
        //             ));
        //           },
        //           child: Text("Inventory Page")),
        //     ],
        //   ),
        // )
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 12, right: 12, bottom: 24),
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                )
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Row(children: [
              for (int i = 0; i < navIcons.length; i++)
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = i;
                    });
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(navIcons[i],
                            size: currentIndex == i ? 28 : 20,
                            color:
                                currentIndex == i ? Colors.red : Colors.black),
                        currentIndex == i
                            ? Container(
                                margin: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                width: 30,
                                height: 4,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                )),
            ]),
          ),
        ),
        body: IndexedStack(
          index: currentIndex,
          // index: 1,
          children: [
            // ...pages,
            // CalenderTab(),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .where('uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return AttHomePage(
                    userData: records(
                        name: snapshot.data!.docs[0]['name'],
                        uid: snapshot.data!.docs[0].id,
                        email: snapshot.data!.docs[0]['Email'],
                        picurl: snapshot.data!.docs[0]['picurl']),
                  );
                }),

            toDoTab(),
            InventoryTab(),
          ],
        ));
  }
}
