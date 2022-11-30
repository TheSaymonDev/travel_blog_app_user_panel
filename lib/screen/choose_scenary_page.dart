import 'package:blog_app/colors/mycolors.dart';
import 'package:blog_app/screen/tab_screen/page1.dart';
import 'package:blog_app/screen/tab_screen/page2.dart';
import 'package:blog_app/screen/tab_screen/page3.dart';
import 'package:blog_app/screen/tab_screen/page4.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ChooseScenaryPage extends StatefulWidget {
  const ChooseScenaryPage({Key? key}) : super(key: key);

  @override
  State<ChooseScenaryPage> createState() => _ChooseScenaryPageState();
}

class _ChooseScenaryPageState extends State<ChooseScenaryPage> {
  List pages=[Page1(), Page2(), Page3(), Page4()];
  int pageIndex=0;
  var selected = 0;
  List<String> myList1 = ['Seaside', 'Hillside', 'Historical', 'Forestside'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldClr,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose Your',
              style: myStyle(40, FontWeight.bold, textClr),
            ),
            Text(
              'Favourite Scenary',
              style: myStyle(40, FontWeight.bold, textClr),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(20),
              height: 200,
              child: MasonryGridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemCount: myList1.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = index;
                      pageIndex=selected;
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>pages[pageIndex]));
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: selected == index
                                ? Colors.transparent
                                : buttonClr,
                            width: 2),
                        color:
                            selected == index ? buttonClr : Colors.transparent),
                    child: Text(
                      myList1[index],
                      style: myStyle(14, FontWeight.bold,
                          selected == index ? scaffoldClr : buttonClr),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height *.40,
              child: ListView(
                children: [
                  CarouselSlider(
                    items: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage('images/seaside.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage('images/hillside.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage('images/historical.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage('images/forest.jpg'),
                                fit: BoxFit.cover)),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 280,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

myStyle(double size, FontWeight weight, Color clr) {
  return TextStyle(fontSize: size, fontWeight: weight, color: clr);
}
