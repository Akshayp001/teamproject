import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamproject/Screens/Homepage.dart';
import 'package:teamproject/Services/GAuthSer.dart';
// import 'package:teamproject/Widgets/borderedFormField.dart';
import 'package:teamproject/Widgets/constants.dart';

class LoginPage extends StatelessWidget {
  GoogleAuthServiesI newGoogleAuth = new GoogleAuthServiesI();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  InputDecoration borderedTextFielddec = InputDecoration(
      alignLabelWithHint: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   title: const Text("Login"),
      // ),
      body: Container(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(
                    'assets/image/tml_black.png',
                  ),
                  height: 300,
                  width: 300,
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                const Text(
                  "Team Maverick",
                  style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),

                ///remove this after imple///
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: ()=>newGoogleAuth.signInwithGoogle(),
                  child: Image(
                    image: AssetImage("assets/image/googleLogo.png"),
                    height: 80,
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sign in with Google",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold),
                )

                ///

                ///
                // const SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                //   child: TextField(
                //     controller: emailController,
                //     decoration: borderedTextFielddec.copyWith(
                //         prefixIcon: Icon(FontAwesomeIcons.envelope),
                //         prefixIconColor: Colors.red,
                //         labelText: "Email",
                //         hintText: "Enter Email"),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                //   child: passwordField(
                //     controller: passwordController,
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         flex: 1,
                //         child: InkWell(
                //           onTap: () => newGoogleAuth.signInwithGoogle(),
                //           child: Container(
                //             margin: EdgeInsets.all(10),
                //             height: 40,
                //             decoration: BoxDecoration(
                //               border: Border.all(color: Colors.amberAccent),
                //               color: Colors.amber.shade100,
                //               borderRadius: BorderRadius.circular(12),
                //             ),
                //             child: const Padding(
                //               padding: EdgeInsets.all(8.0),
                //               child: Image(
                //                   height: 10,
                //                   width: 10,
                //                   image: AssetImage(
                //                       'assets/image/googleLogo.png')),
                //             ),
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 3,
                //         child: InkWell(
                //           onTap: () {
                //             Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) {
                //                 return Homepage();
                //               },
                //             ));
                //           },
                //           child: GestureDetector(
                //             onTap: () => newGoogleAuth.signInWithCreds(
                //                 emailController.text.trim(),
                //                 passwordController.text.trim()),
                //             child: Container(
                //               margin: EdgeInsets.all(10),
                //               height: 40,
                //               decoration: BoxDecoration(
                //                 color: Colors.amber,
                //                 borderRadius: BorderRadius.circular(12),
                //               ),
                //               child: const Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Center(
                //                     child: Text(
                //                   "Login",
                //                   style: TextStyle(
                //                       fontFamily: 'Rubik',
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold),
                //                 )),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // InkWell(
                //   onTap: () {},
                //   child: const Text(
                //     "Not Registered, Sign up!!",
                //     style: TextStyle(
                //         fontSize: 15,
                //         fontFamily: 'Nunito',
                //         color: Colors.lightBlue),
                //   ),
                // )
              ])),
    );
  }

  // signInwithGoogle() async {
  //   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication? googleauth = await googleUser?.authentication;

  //   AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleauth?.accessToken,
  //     idToken: googleauth?.idToken,
  //   );

  //   UserCredential userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  // }
}

class passwordField extends StatefulWidget {
  var controller = new TextEditingController();
  passwordField({required this.controller});

  @override
  State<passwordField> createState() => _passwordFieldState();
}

class _passwordFieldState extends State<passwordField> {
  late bool showPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !showPassword,
      controller: widget.controller,
      decoration: borderedTextFielddec.copyWith(
        prefixIcon: Icon(FontAwesomeIcons.key),
        prefixIconColor: Colors.red,
        suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            child: Icon(showPassword
                ? FontAwesomeIcons.eyeSlash
                : FontAwesomeIcons.eye)),
        labelText: "Password",
        hintText: "Enter Passoword",
      ),
    );
  }
}
