import 'package:blog_app/colors/mycolors.dart';
import 'package:blog_app/screen/choose_scenary_page.dart';
import 'package:blog_app/screen/details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  bool isRed = false;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('forestside').snapshots();
    return Scaffold(
      backgroundColor: scaffoldClr2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: buttonClr2,
        leading: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(shape: BoxShape.circle, color: textClr2),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                size: 20,
                color: scaffoldClr,
              )),
        ),
        centerTitle: true,
        title: Text(
          'Forestside',
          style: myStyle(18, FontWeight.bold, textClr),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Where do you \nwant go?',
                              style: myStyle(35, FontWeight.bold, textClr),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide.none),
                                          filled: true,
                                          prefixIcon: Icon(Icons.search),
                                          hintStyle: myStyle(
                                              14, FontWeight.normal, textClr2),
                                          hintText: "Search Place",
                                          fillColor: scaffoldClr),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: iconClr),
                                  child: Icon(
                                    Icons.sort,
                                    size: 25,
                                    color: scaffoldClr,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                Expanded(
                  flex: 6,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                    img: data['img'],
                                    title: data['title'],
                                    des: data['des'],
                                  )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8),
                          padding: EdgeInsets.all(10),
                          height: double.infinity,
                          width: MediaQuery.of(context).size.width * .75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: scaffoldClr,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(data['img']),
                                          fit: BoxFit.cover)),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5)),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isRed = !isRed;
                                            });
                                          },
                                          icon: Icon(
                                            isRed == false
                                                ? Icons.favorite_border
                                                : Icons.favorite,
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data['title'],
                                    style:
                                        myStyle(18, FontWeight.bold, textClr),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 18,
                                        color: ratingClr,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        '4.8/5',
                                        style: myStyle(
                                            12, FontWeight.normal, textClr),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 18,
                                    color: textClr2,
                                  ),
                                  Text(
                                    'California, USA',
                                    style: myStyle(
                                        14, FontWeight.normal, textClr2),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
