import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../others/constants.dart';

class GoogleAuthServiesI {
  var FFdb = FirebaseFirestore.instance;
  final _inventoryColRef =
      FirebaseFirestore.instance.collection(INVENTORY_ITEMS_COLLECTION);
  signInwithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleauth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleauth?.accessToken,
      idToken: googleauth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    var uid = userCredential.user!.uid.toString();
    var checkUid = FFdb.collection("Users")
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) {
      if (value.size == 0 && userCredential.user != null) {
        FFdb.collection('Users').add({
          "name": userCredential.user!.displayName.toString(),
          "Email": userCredential.user!.email.toString(),
          "atoken": googleauth?.accessToken.toString(),
          "idtoken": googleauth?.idToken.toString(),
          "picurl": userCredential.user!.photoURL.toString(),
          "uid": userCredential.user!.uid.toString(),
          "password": "team001",
        });
      } else {
        print("User Exits : Successful Login");
      }
    });
    // print("UID of  User: " + checkUid.toString());
    // print("UID of  User: " + userCredential.user.toString());
    // if () {
    //   print("Entered In If Block.......................");
    //   FFdb.collection('Users').add({
    //     "name": userCredential.user!.displayName.toString(),
    //     "Email": userCredential.user!.email.toString(),
    //     "atoken": credential.accessToken.toString(),
    //     "idtoken": credential.token.toString(),
    //     "picurl": userCredential.user!.photoURL.toString(),
    //     "uid": userCredential.user!.uid.toString(),
    //   });
    // }
  }

  signOutWithGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  signInWithCreds(String email, String password) async {
    var FFdb = FirebaseFirestore.instance;

    FFdb.collection("Users")
        .where("Email", isEqualTo: email)
        .get()
        .then((value) async {
      if (value.docs[0]["password"] == password) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
              accessToken: value.docs[0]["atoken"],
              idToken: value.docs[0]["idtoken"]),
        );

        if (userCredential.user != null) {
          print("Sign in Successfull");
        } else {
          print("Error Signing in");
        }
      }
    });

    // getInventoryData(String id) {
    //   Stre data = _inventoryColRef.doc(id);
    //   return data.get().;
    // }

    // UserCredential userCredential =
    //     await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
