import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class RestAPI extends StatelessWidget {
  const RestAPI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: Text('Shimmer View'),
      ),
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataModal> dataList = [];
  bool isLoading = true;

  getData() async {
    final url = Uri.parse('https://jsonkeeper.com/b/6L5J');
    http.Response response =
        await http.get(url, headers: {'Accept': 'application/json'});
    print(response.body);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    setState(() {
      dataList = List<DataModal>.from(
          jsonData["data"].map((x) => DataModal.fromJson(x)));
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          // ? Center(
          //     child: CircularProgressIndicator(),
          //   )
          ? ListView.builder(
              itemCount: 9,
              itemBuilder: (context, index) {
                return ShimmerCard();
              })
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return DataCard(
                  languageName: dataList[index].languageName,
                  languageDesc: dataList[index].languageDesc,
                  languageImg: dataList[index].languageImg,
                );
              },
            ),
    );
  }
}

class DataModal {
  DataModal({
    this.languageName,
    this.languageImg,
    this.languageDesc,
  });

  String languageName;
  String languageImg;
  String languageDesc;

  factory DataModal.fromJson(Map<String, dynamic> json) => DataModal(
        languageName: json['languageName'],
        languageDesc: json["languageDesc"],
        languageImg: json['languageimg'],
      );
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white24,
      child: Container(
          margin: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.white24,
                highlightColor: Colors.white38,
                child: Container(
                  color: Colors.grey,
                  height: 80,
                  width: 80,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shimmer.fromColors(
                  //   baseColor: Colors.grey[300],
                  //   highlightColor: Colors.grey[100],
                  //   child: Container(
                  //     color: Colors.grey,
                  //     child: Text(
                  //       "",
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 8,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.white24,
                    highlightColor: Colors.white38,
                    child: Container(
                      width: 230,
                      color: Colors.grey,
                      child: Text(
                        "",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class DataCard extends StatelessWidget {
  final String languageImg;
  final String languageName, languageDesc;

  DataCard({this.languageImg, this.languageName, this.languageDesc});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white24,
      child: Container(
          margin: EdgeInsets.all(8.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: languageImg,
                height: 80,
                width: 80,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languageName + " Language",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Container(
                  //   width: 230,
                  //   child: Text(
                  //     languageDesc,
                  //     maxLines: 20,
                  //     style: TextStyle(color: Colors.black, fontSize: 15),
                  //   ),
                  // ),
                ],
              )
            ],
          )),
    );
  }
}
