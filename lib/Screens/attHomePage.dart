import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:teamproject/Models/userMod.dart';

import '../Models/userModule.dart';

class AttHomePage extends StatelessWidget {
  records? userData;
  final User? user = FirebaseAuth.instance.currentUser;

  // List<records> tu = [];

  // var tempUsers = FirebaseFirestore.instance
  //     .collection('Users')
  //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //     .get();

  // getusers(String uid) async {
  //   QuerySnapshot<Map<String, dynamic>> tempUsers = await FirebaseFirestore
  //       .instance
  //       .collection('Users')
  //       .where('uid', isEqualTo: uid)
  //       .get();
  //   // return tempUsers.docs
  //   //     .map((e) =>
  //   //         records(name: e['name'], email: e['Email'], uid: e.id.toString()))
  //   //     .toList();
  //   mapRecords(tempUsers);
  // }

  // mapRecords(QuerySnapshot<Map<String, dynamic>> recs) {
  //   tu = recs.docs
  //       .map((e) =>
  //           records(name: e['name'], email: e['Email'], uid: e.id.toString()))
  //       .toList();
  // }

  // getIdofUser()  {
  //   var id;
  // final docref = FirebaseFirestore.instance
  //     .collection('Users')
  //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser)
  //     .get()
  //     .then((value) {
  //   // print(value.docs[0].id.toString());
  //   // var temp = value.docs[0];
  //   // id = temp["Email"];
  //   print("length : " + value.docs.length.toString());
  //   print("Email : " + value.docs[0]["Email"]);
  // });
  //   // return id;
  // }

  // final _userReferance =
  //     FirebaseFirestore.instance.collection('Users').doc(userId.toString());
  // Function keyFun;
  // AttHomePage({this.userData, required this.keyFun});

  AttHomePage({this.userData});

  // openDrawer() {
  //   keyFun();
  // }

  @override
  Widget build(BuildContext context) {
    final DocumentReference _attendenceRecord = FirebaseFirestore.instance
        .collection('attendence')
        .doc(DateFormat.yMMMEd().format(DateTime.now()).toString());
    final CollectionReference _userRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userData!.uid.toString())
        .collection('AttRecords');

    // List<records> tu = getusers(user!.uid);
    // getusers(user!.uid);
    // print(tu[0].name);
    print(userData!.name.toString());

    // getIdofUser();
    // print("id" + getIdofUser().toString());
    // final _
    // eFirestore.instance.collection('Users').doc();
    // print(_userReferance.id);
    // print(user!.displayName);
    // print(_userReferance.collection("AttRecords").add({
    //   "date": DateFormat.yMMMEd().format(DateTime.now()),
    //   "check_in": "MT",
    //   "check_out": "MT",
    // }));

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // color: Colors.amber.shade100,
      // decoration: const BoxDecoration(
      // image: DecorationImage(
      //     image: NetworkImage(
      //         'https://firebasestorage.googleapis.com/v0/b/test-project-25a53.appspot.com/o/prperller.jpg?alt=media&token=94076220-2c2f-45b6-bde6-718ba8a7380c'),
      //     fit: BoxFit.cover,
      //     opacity: 0.5,
      //     colorFilter: ColorFilter.mode(Colors.amber, BlendMode.dstIn))),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome,",
                        style: TextStyle(fontSize: 24, fontFamily: 'Nunito'),
                      ),
                      Text(userData!.name.toString(),
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito'))
                    ]),
              ),
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 32,
                  child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(userData!.picurl.toString())),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  // color: Colors.lightBlue.withOpacity(0.3),
                  image: const DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Colors.lightBlue, BlendMode.color),
                      fit: BoxFit.cover,
                      image: AssetImage('assets/image/skybluebg.jpg')),
                  border: Border.all(width: 1, color: Colors.black26),
                  borderRadius: BorderRadius.circular(12)),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Today's Status",
                      style: TextStyle(
                          fontSize: screenWidth / 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito')),
                  StreamBuilder<DocumentSnapshot>(
                      stream: _userRef
                          .doc(DateFormat.yMMMEd()
                              .format(DateTime.now())
                              .toString())
                          .snapshots(),
                      builder: (context, snapshot) {
                        var temp = snapshot.data?.exists;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Check In",
                                    style: TextStyle(
                                        fontSize: screenWidth / 20,
                                        fontFamily: 'Nunito')),
                                Text(
                                    temp == true
                                        ? (snapshot.data?["check_in"])
                                        : "--/--",
                                    style: TextStyle(
                                        fontSize: screenWidth / 19,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito'))
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Check out",
                                    style: TextStyle(
                                        fontSize: screenWidth / 20,
                                        fontFamily: 'Nunito')),
                                Text(
                                    (temp == true &&
                                            snapshot.data?["check_out"] != "")
                                        ? (snapshot.data?["check_out"])
                                        : "--/--",
                                    style: TextStyle(
                                        fontSize: screenWidth / 19,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito'))
                              ],
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.only(left: 8, top: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              "${DateFormat('d MMM , yyyy').format(DateTime.now())}",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito'),
            ),
          ),
          StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.only(left: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${DateFormat('hh:mm:ss a').format(DateTime.now())}",
                    style: const TextStyle(
                        letterSpacing: 1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito'),
                  ),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          Builder(builder: (context) {
            GlobalKey<SlideActionState> slideKey = GlobalKey();
            return StreamBuilder<DocumentSnapshot>(
                stream: _userRef
                    .doc(DateFormat.yMMMEd().format(DateTime.now()).toString())
                    .snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.data?.exists == true &&
                          snapshot.data?["check_in"] != "" &&
                          snapshot.data?["check_out"] != "")
                      ? GestureDetector(
                          onTap: () => _userRef
                              .doc(DateFormat.yMMMEd()
                                  .format(DateTime.now())
                                  .toString())
                              .delete(),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.red,
                                      blurRadius: 10,
                                      blurStyle: BlurStyle.outer)
                                ],
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.amber.shade200.withOpacity(0.4)),
                            height: 70,
                            child: Center(
                                child: Text(
                              "Today's Work Completed!! 😀",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth / 16,
                                  fontFamily: "Rubik"),
                            )),
                          ),
                        )
                      : SlideAction(
                          key: slideKey,
                          onSubmit: () {
                            if (snapshot.data?.exists == false) {
                              _userRef
                                  .doc(DateFormat.yMMMEd()
                                      .format(DateTime.now())
                                      .toString())
                                  .set({
                                "Date": DateFormat.yMEd()
                                    .format(DateTime.now())
                                    .toString(),
                                "check_in": DateFormat('hh:mm')
                                    .format(DateTime.now())
                                    .toString(),
                                "check_out": "",
                              });

                              Timer.periodic(Duration(seconds: 1), (timer) {
                                slideKey.currentState!.reset();
                                timer.cancel();
                              });
                            } else if (snapshot.data?.exists == true &&
                                snapshot.data?["check_in"] != "" &&
                                snapshot.data?["check_out"] == "") {
                              _userRef
                                  .doc(DateFormat.yMMMEd()
                                      .format(DateTime.now())
                                      .toString())
                                  .update({
                                "check_out": DateFormat('hh:mm')
                                    .format(DateTime.now())
                                    .toString(),
                              }).then((value) {
                                var doc = _attendenceRecord
                                    .collection('records')
                                    .doc(user!.email);
                                doc.set({
                                  "status": "Present",
                                  "check_in": snapshot.data?["check_in"],
                                  "check_out": DateFormat('hh:mm')
                                      .format(DateTime.now())
                                      .toString(),
                                });
                              });
                            }
                          },
                          text: (snapshot.data?.exists == false)
                              ? "Slide to Check-In"
                              : (snapshot.data?["check_out"] == ""
                                  ? "Slide to Check-Out"
                                  : ""),
                          outerColor: Colors.amber[100],
                          innerColor: Colors.amber.shade800,
                          elevation: 10,
                          textStyle: TextStyle(
                              fontSize: screenWidth / 16, fontFamily: "Rubik"),
                        );
                });
          })
        ],
      ),
    );
  }
}
