import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:zee_tree/summary.dart';
import 'package:zee_tree/images.dart';
import 'package:zee_tree/profile.dart';
import 'package:zee_tree/upload.dart';
import 'data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Data> dataList = [];
  @override
  void initState() {
    super.initState();
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child('Users');
    referenceData.once().then((DataSnapshot dataSnapShot) {
      dataList.clear();
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;
      for (var key in keys) {
        Data data = new Data(
          values[key]['image'],
          values[key]['name'],
          values[key]['location'],
        );
        dataList.add(data);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataList.length,
        itemBuilder: (_, index) {
          return homeview(
            dataList[index].image,
            dataList[index].location,
            dataList[index].name,
          );
        },
      )),
      buttonview()
    ]));
  }

  Widget homeview(String image, String name, String location) {
    return Container(
        //color: Colors.green,
        height: 640,
        width: 360,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              child: Column(children: <Widget>[
                Row(
                  children: [
                    Summary(dataList.length.toString()),
                    IImage(image),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Profile(name, location)
                  ],
                )
              ]),
            ),
          ],
        ));
  }

  Widget buttonview() {
    return Container(
      child: Row(
        children: [
          Container(
            height: 62,
            width: 180,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Home',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 62,
            width: 180,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadingImage()),
                );
              },
              child: const Text(
                'Post',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
