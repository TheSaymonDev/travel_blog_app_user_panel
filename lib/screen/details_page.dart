import 'package:blog_app/colors/mycolors.dart';
import 'package:blog_app/screen/choose_scenary_page.dart';
import 'package:blog_app/screen/vlog_videos.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, this.img, this.title, this.des}) : super(key: key);

  String? img;
  String? title;
  String? des;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isRed = false;
  bool isReadMore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldClr2,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      // image: DecorationImage(image: NetworkImage('${widget.img}'), fit: BoxFit.cover),
                      image: DecorationImage(
                          image: NetworkImage('${widget.img}'),
                          fit: BoxFit.cover),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: textClr2),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: 22,
                                color: scaffoldClr,
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: textClr2),
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
                      ],
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.title}',
                            style: myStyle(25, FontWeight.bold, textClr),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 18,
                                color: textClr2,
                              ),
                              Text(
                                'California, USA',
                                style: myStyle(14, FontWeight.normal, textClr2),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: scaffoldClr),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'About This Place',
                                  style: myStyle(18, FontWeight.bold, textClr),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: iconClr),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VlogVideos()));
                                          },
                                          icon: Icon(
                                            Icons.play_arrow_outlined,
                                            size: 25,
                                            color: scaffoldClr,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Watch Vlogs',
                                      style:
                                          myStyle(12, FontWeight.bold, textClr),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text(
                            '${widget.des}',
                            style: myStyle(16, FontWeight.normal, textClr),
                            maxLines: isReadMore ? null : 10,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isReadMore = !isReadMore;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: buttonClr),
                              child: Text(
                                isReadMore ? 'Read less' : 'Read more ...',
                                style:
                                    myStyle(14, FontWeight.bold, scaffoldClr),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
