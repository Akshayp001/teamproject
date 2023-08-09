import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class BottomNavBarCust extends StatefulWidget {
  List<IconData> navIcons;

  BottomNavBarCust({required this.navIcons});

  @override
  State<BottomNavBarCust> createState() => _BottomNavBarCustState();
}

class _BottomNavBarCustState extends State<BottomNavBarCust> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
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
          for (int i = 0; i < widget.navIcons.length; i++)
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
                    Icon(widget.navIcons[i],
                        size: currentIndex == i ? 28 : 20,
                        color: currentIndex == i ? Colors.red : Colors.black),
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
    );
  }
}
