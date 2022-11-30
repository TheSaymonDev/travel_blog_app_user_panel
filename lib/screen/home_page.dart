import 'package:blog_app/screen/tab_screen/page1.dart';
import 'package:blog_app/screen/tab_screen/page2.dart';
import 'package:blog_app/screen/tab_screen/page3.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   List pages=[Page1(),Page2(),Page3()];
   int pageIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Page'),
      ),
      bottomNavigationBar: CurvedNavigationBar(items: [
        Icon(Icons.add, size: 30),
        Icon(Icons.list, size: 30),
        Icon(Icons.compare_arrows, size: 30),
      ],
        onTap: (index) {
          setState(() {
            pageIndex=index;
          });
        },),
      body: pages[pageIndex],
    );
  }
}
