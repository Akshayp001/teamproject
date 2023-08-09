import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teamproject/Screens/MembersScreen.dart';
import 'package:teamproject/Services/GAuthSer.dart';

import '../Screens/userProfileScreen.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key? key,
    required this.userEmail,
    required this.userName,
    required this.userPicUrl,
  }) : super(key: key);

  final String userEmail;
  final String userName;
  final String userPicUrl;
  GoogleAuthServiesI authserv = new GoogleAuthServiesI();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return HomePageWidget(
                    userEmail: userEmail,
                    userName: userName,
                    userPicUrl: userPicUrl,
                  );
                },
              )),
              child: CircleAvatar(
                backgroundImage: NetworkImage(userPicUrl),
              ),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.powerOff),
            title: Text('Logout'),
            onTap: () => authserv.signOutWithGoogle(),
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () {
          //     // TODO: implement settings
          //   },
          // ),
          ListTile(
            leading: Icon(FontAwesomeIcons.peopleGroup),
            title: Text('Members'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MembersScreen(),
            )),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class MyDrawer extends StatelessWidget {
//   const MyDrawer({
//     Key? key,
//     required this.userEmail,
//     required this.userName,
//     required this.userPicUrl,
//   }) : super(key: key);

//   final String userEmail;
//   final String userName;
//   final String userPicUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: Container(
//             color: Colors.blueGrey[900],
//             child: ListView(padding: EdgeInsets.zero, children: <Widget>[
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.blueGrey[900],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: NetworkImage(userPicUrl),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       userName,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       userEmail,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.logout,
//                   color: Colors.white,
//                 ),
//                 title: Text(
//                   'Logout',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 onTap: () {
//                   // TODO: implement logout
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.settings,
//                   color: Colors.white,
//                 ),
//                 title: Text(
//                   'Settings',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 onTap: () {},
//               )
//             ])));
//   }
// }
