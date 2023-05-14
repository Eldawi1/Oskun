import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'profile.dart';
import 'details.dart';

class history extends StatefulWidget {
  final int? id;
  const history({Key? key, required this.id}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  int i = 0;
  List<historyhouse> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black, // adding color to app bar
          centerTitle: true, // centering the title
          title: Text(
            'History',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext, int i) {
              return SizedBox(width: 10);
            },
            itemCount: list.length,
            itemBuilder: (context, int i) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return details(id: list[i].id!, userId: list[i].id!);
                    }));
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 330,
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(top: 3, right: 3, left: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  height: 200,
                                  width: 600,
                                  '${list[i].mainImage}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  '${list[i].name}'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2475EC)),
                                  "\$${list[i].price}"),
                              Row(
                                children: [Text(style: TextStyle(fontWeight: FontWeight.bold),'Start Date: '),
                                  Text('${list[i].map!['startDate']}')
                                ],
                              ),
                              Row(
                                children: [Text(style: TextStyle(fontWeight: FontWeight.bold),'End Date: '),
                                  Text(
                                      ' ${list[i].map!['endDate']}')
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 10,
                                    ),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.bed),
                                        Text(
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            '${list[i].bedsNumber} beds')
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 10, left: 45, right: 40),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.bathtub),
                                        Text(
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            '${list[i].bathsNumber}baths')
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 3),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.fullscreen_outlined),
                                        Text(
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            '${list[i].size}m')
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(left: 5, top: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white60),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                                size: 15,
                                color: Colors.black,
                                Icons.location_on),
                            Text(
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                '${list[i].location}'),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white60),
                          margin: EdgeInsets.only(top: 6, left: 350),
                          child: GestureDetector(
                              onTap: () {},
                              child: Icon(size: 20, Icons.favorite_border))),
                      Container(
                        margin: EdgeInsets.only(left: 320, top: 205),
                        child: Row(
                          children: [
                            Icon(color: Colors.yellow, Icons.star),
                            Text(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                '${list[i].rating}'),
                          ],
                        ),
                      )
                    ],
                  ));
            }));
  }

  @override
  void initState() {
    getHouse(widget.id!);
    print(widget.id);
  }

  Future<void> getHouse(int id) async {
    http.Response response =
        await http.get(Uri.parse('http://api.bluelightlms.com/history?id=$id'));
    Map<String, dynamic> map = json.decode(response.body);
    String message = map['message'];
    List data = map['data'];
    print('_____________________________________________');
    print(data);
    print(message);
    print('_____________________________________________');
    setState(() {
      for (i = 0; i < data.length; i++) {
        historyhouse Historyhouse = historyhouse.fromjson(data[i]);
        list.add(Historyhouse);
      }
    });
  }
}

class historyhouse {
  String? name;
  String? location;
  int? bedsNumber;
  int? bathsNumber;
  String? mainImage;
  double? rating;
  int? size;
  int? price;
  int? id;
  Map<String, dynamic>? map;
  historyhouse.fromjson(Map<String, dynamic> data) {
    name = data['name'];
    location = data['location'];
    bedsNumber = data['beds'];
    bathsNumber = data['baths'];
    mainImage = data['mainImg'];
    rating = data['rating'];
    size = data['size'];
    price = data['price'];
    id = data['id'];
    map = data['history'];
  }
}
