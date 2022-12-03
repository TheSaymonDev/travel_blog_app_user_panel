import 'package:blog_app/colors/mycolors.dart';
import 'package:blog_app/screen/choose_scenary_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VlogVideos extends StatefulWidget {
  const VlogVideos({Key? key}) : super(key: key);

  @override
  State<VlogVideos> createState() => _VlogVideosState();
}

class _VlogVideosState extends State<VlogVideos> {
  late YoutubePlayerController controller;
  String url = 'https://www.youtube.com/watch?v=s3RbCgC4kCU';

  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('seaside').snapshots();
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
          'Vlog Videos',
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

          return Column(
            children: [
              Container(
                child: YoutubePlayerBuilder(
                    player: YoutubePlayer(controller: controller),
                    builder: (context, player) => player),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        url = data['videos'];
                        controller.load(YoutubePlayer.convertUrlToId(url)!);
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          padding: EdgeInsets.all(10),
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: scaffoldClr),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(data['img']),
                                        fit: BoxFit.cover)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['title'],
                                    style:
                                        myStyle(18, FontWeight.bold, textClr),
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Saymon Vlogs',
                                        style: myStyle(
                                            12, FontWeight.bold, textClr2),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '🕰️ 3.55',
                                        style: myStyle(
                                            12, FontWeight.bold, textClr2),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: iconClr),
                                child: Icon(
                                  Icons.play_arrow_outlined,
                                  color: scaffoldClr,
                                ),
                              ),
                            ],
                          )),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
