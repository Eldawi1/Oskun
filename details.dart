import 'package:flutter/material.dart';
import 'package:soft/HomePgae.dart';
import 'Repeat.dart';
import 'pic.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class details extends StatefulWidget {
  final int id;
  final int userId;

  const details({Key? key, required this.id, required this.userId})
      : super(key: key);

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  void _showPopup() {
    DateTime? startDate;
    DateTime? endDate;
    int? period;
    int? pricePerDay = 100;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Book Now',
            textAlign: TextAlign.center,
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    readOnly: true,
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          startDate = selectedDate;
                          if (endDate != null) {
                            period = endDate!.difference(startDate!).inDays;
                          }
                        });
                      }
                    },
                    controller: TextEditingController(
                        text: startDate?.toString().split(' ')[0] ?? ''),
                    decoration: InputDecoration(
                      labelText: "Starting Date",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: endDate ?? startDate ?? DateTime.now(),
                        firstDate: startDate ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          endDate = selectedDate;
                          if (startDate != null) {
                            period = endDate!.difference(startDate!).inDays;
                          }
                        });
                      }
                    },
                    controller: TextEditingController(
                        text: endDate?.toString().split(' ')[0] ?? ''),
                    decoration: InputDecoration(
                      labelText: "Ending Date",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    controller:
                        TextEditingController(text: period?.toString() ?? ''),
                    decoration: InputDecoration(labelText: "Period"),
                  ),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: (price ?? 0) * (period ?? 0) == 0
                            ? ''
                            : '\$${(price! * period!).toString()}'),
                    decoration: InputDecoration(labelText: "Total Price"),
                  ),
                  SizedBox(
                    height: 16,
                    child: Container(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        bookHouse(
                            widget.userId.toString(),
                            widget.id.toString(),
                            startDate.toString(),
                            endDate.toString(),
                            (price! * period!).toDouble(),false);

                      },
                      child: Text(
                        'Confirm Booking',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  PageController _pageController = PageController(initialPage: 0);
  Map<String, dynamic>? data;
  int? owner;
  String? location;
  String? name;
  String? des;
  int? baths;
  int? size;
  int? beds;
  int? price;
  String? mainImage;

  int i = 0;
  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    return _widget();
  }

  Widget _widget() {
    if (data == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        bottomNavigationBar: Container(
          height: 90,
          decoration: BoxDecoration(color: Colors.white60),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 30),
                child: Text(
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                    '\$${price}'),
              ),
              Container(
                  margin: EdgeInsets.only(left: 12, top: 10),
                  child: Text(
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      'Price')),
              Container(
                margin:
                    EdgeInsets.only(bottom: 10, top: 10, left: 200, right: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(300, 100),
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: _showPopup,
                    child: Text('Book Now')),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ListView(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 385,
                      child: ListView.builder(
                        controller: _pageController,
                        itemCount: list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return picture();
                                }));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 385,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Padding(
                                      padding: EdgeInsets.only(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InteractiveViewer(
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: ClipRRect(
                                                child: Image.network(
                                                  height: 350,
                                                  width: 500,
                                                  '${list[i]}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 330, top: 20),
                      child: GestureDetector(
                          onTap: () {}, child: Icon(Icons.favorite_border)),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 28, left: 20),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(color: Colors.orange, Icons.arrow_back)),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 150, top: 20),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.white),
                      child: Text(
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          'Details'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 200),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: GestureDetector(
                                onTap: () {
                                  _pageController.previousPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Icon(size: 30, Icons.arrow_back)),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 260),
                            child: GestureDetector(
                                onTap: () {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Icon(size: 30, Icons.arrow_forward)),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        '${name}')
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(color: Colors.grey, Icons.location_on),
                    Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        '${location}')
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(color: Colors.grey, Icons.person),
                    Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        '${owner}')
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orangeAccent.withOpacity(0.2)),
                    child: Row(
                      children: [
                        Icon(color: Colors.deepOrange, Icons.bed),
                        Text('${beds} beds'),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(color: Colors.deepOrange, Icons.bathtub_rounded),
                        Text('${baths} baths'),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                            color: Colors.deepOrange,
                            Icons.fullscreen_outlined),
                        Text('${size}m')
                      ],
                    )),
                Container(
                  child: Text(
                      style: TextStyle(color: Colors.grey),
                      "As the sun sets over the horizon, the sound of waves crashing against the shore fills the air. A lone seagull swoops down to catch its evening meal, while a group of children build sandcastles nearby. The salty sea breeze carries the scent of sunscreen and saltwater, as beachgoers soak up the last rays of the day. It's the perfect ending to a day filled with fun in the sun."),
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    getHouseDetails(widget.id);
  }

  Future<void> getHouseDetails(int id) async {
    final http.Response response = await http.get(
      Uri.parse('http://api.bluelightlms.com/HouseDetails?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> map = json.decode(response.body);
    print(response.body);

    if (response.statusCode == 200) {
      String? message = map['message'];
      if (message != null && message == 'Done') {
        data = map['data'];

        if (data != null) {
          setState(() {
            name = data!['name'];
            owner = data!['owner'];
            location = data!['location'];
            price = data!['price'];
            mainImage = data!['mainImg'];
            beds = data!['beds'];
            baths = data!['baths'];
            size = data!['size'];
            des = data!['description'];
          });
        }

        print('-----------------------------------------------------n');
        print(data);
        print('-----------------------------------------------------n');

        // Process data here
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Something went wrong'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status code not 200')),
      );
    }
    list = [
      '${mainImage}',
      'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%A3%D8%AD%D8%AF%D8%AB-%D8%AF%D9%8A%D9%83%D9%88%D8%B1%D8%A7%D8%AA-%D8%B4%D9%82%D9%82-2023-1.jpg',
      'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%AF%D9%8A%D9%83%D9%88%D8%B1-%D8%B4%D9%82%D9%82-2023-1.jpg',
      'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%AF%D9%8A%D9%83%D9%88%D8%B1-%D8%B4%D9%82%D9%82-2023-2.jpg',
      'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%AF%D9%8A%D9%83%D9%88%D8%B1%D8%A7%D8%AA-%D8%B4%D9%82%D9%822023-1.jpg',
      'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%AF%D9%8A%D9%83%D9%88%D8%B1%D8%A7%D8%AA-%D8%B4%D9%82%D9%822023-2.jpg',
      'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%AF%D9%8A%D9%83%D9%88%D8%B1%D8%A7%D8%AA-%D8%B4%D9%82%D9%822023-3.jpg',
      'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%AF%D9%8A%D9%83%D9%88%D8%B1%D8%A7%D8%AA-%D8%B4%D9%82%D9%82-%D8%B1%D8%A7%D9%82%D9%8A%D8%A9-%D8%AC%D8%AF%D8%A7-%D9%88%D9%81%D8%AE%D9%85%D8%A9-2.jpg',
      'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%A7%D8%AD%D8%AF%D8%AB-%D8%AF%D9%8A%D9%83%D9%88%D8%B1%D8%A7%D8%AA-%D8%B4%D9%82%D9%82-%D9%85%D8%AE%D8%AA%D9%84%D9%81%D8%A9-1.jpg',
      'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%A7%D8%AD%D8%AF%D8%AB-%D8%AF%D9%8A%D9%83%D9%88%D8%B1%D8%A7%D8%AA-%D8%B4%D9%82%D9%82-%D9%85%D8%AE%D8%AA%D9%84%D9%81%D8%A9-2.jpg'
    ];
  }

  Future<void> bookHouse(String userId, String houseId,
      String startDate, String endDate, double price , bool will) async {
    final url = Uri.parse('http://api.bluelightlms.com/booking');

    final http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          'userId': userId,
          'HouseId': houseId,
          'startDate': startDate,
          'endDate': endDate,
          'price': price.toString(),
          'willRenew' : will.toString()
        }),
      );
    Map<String, dynamic> map= json.decode(response.body);
      if (response.statusCode == 200) {

        print(map['message']);
        Navigator.of(context).pop();

      }
      else{
        print('Error');
      }

  }
}
