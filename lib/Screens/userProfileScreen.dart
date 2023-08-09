import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({
    Key? key,
    required this.userEmail,
    required this.userName,
    required this.userPicUrl,
  }) : super(key: key);

  final String userEmail;
  final String userName;
  final String userPicUrl;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 390,
                  height: 191,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-0.13, -1.03),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://blog.paper.li/wp-content/uploads/2020/02/LinkedIn-banner-5-1070x268.png',
                            width: 405,
                            height: 119,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(
                            -screenWidth / 450, screenHeight / 1100),
                        child: CircleAvatar(
                          radius: screenWidth / 8,
                          backgroundColor: Colors.red,
                          child: CircleAvatar(
                            maxRadius: screenWidth / 8.3,
                            backgroundImage: NetworkImage(
                              widget.userPicUrl,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(
                            screenWidth / 100000, screenHeight / 1600),
                        child: Text(
                          widget.userName,
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: screenWidth / 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(
                            screenWidth / 4100, screenHeight / 1100),
                        child: Text(
                          widget.userEmail,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: screenWidth / 31,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: 420,
              height: 13,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Text(
                'Designation : NOT_SET_YET',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: screenWidth / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Colors.black38,
            ),
            SizedBox(
              height: 200,
            ),
            Text(
              'Comming soon..',
              style: TextStyle(color: Colors.black38),
            )
          ],
        ),
      ),
    );
  }
}
