import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:teamproject/Models/userModule.dart';
import 'package:teamproject/Screens/Homepage.dart';
import 'package:teamproject/Screens/InventoryListScreen.dart';
import 'package:teamproject/Screens/loginPage.dart';
import 'package:teamproject/Services/InventoryProvider.dart';

import 'Widgets/BottomSheet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(child: MyApp(), providers: [
      ChangeNotifierProvider(create: (_) => InventoryProvider()),
    ]),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.light,
      ),
      home: false
          // ? InventoryListScreen()
          ? Material(child: MyBottomSheet(),)
          : StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data == null) {
                    return LoginPage();
                  } else {
                    return Homepage(
                      userData: UserOfApp(
                          emailAd: snapshot.data?.email,
                          picUrl: snapshot.data?.photoURL,
                          name: snapshot.data?.displayName),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
    );
  }
}
