import 'package:flutter/material.dart';
import 'package:soft/fav.dart';
import 'signin.dart';
import 'details.dart';
import 'class.dart';
import 'Repeat.dart';
import 'pic.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import 'profile (1).dart';

import 'package:shared_preferences/shared_preferences.dart';
class House {
  String imageUrl;
  String Location;
  String Name;
  int beds;
  int baths;
  double area;
  double price;

  House(
      {required this.imageUrl,
        required this.Location,
        required this.Name,
        required this.beds,required this.baths,required this.area,required this.price});
}

List<Widget> Widgets = [];

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: homepage(),
  ));
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String searchText = '';
  String? name;
  String? email;
  String? image;
  List<availhomes> list = [];
  int i=0;

  List<House> houses = [];
  String? user;
  int? id;
  Map<String, dynamic>? decodedToken;



  String imageUrl='';
  String Location='';
  String Name='';
  int beds=0;
  int baths=0;
  double area=0;
  double price=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Add House'),
                  content: SingleChildScrollView(
                    child: Container(
                      height: 200,

                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter image URL',


                              ),
                              onChanged: (value) {
                                setState(() {
                                  imageUrl = value;
                                });
                              },
                            ),
                            SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter location',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  Location = value;
                                });
                              },
                            ),
                            SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter Name',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  Name = value;
                                });
                              },
                            ),
                            SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter number of beds',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  beds = int.parse(value);
                                });
                              },
                            ), SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter number of baths',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  baths = int.parse(value);
                                });
                              },
                            ), SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter Area',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  area = double.parse(value);
                                });
                              },
                            ), SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter Price',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  price = double.parse(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          houses.add(House(
                              imageUrl: imageUrl,
                              Location: Location,
                              Name: Name,
                              beds: beds,baths: baths,area: area,price: price));

                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Save'),
                    ),
                  ],
                ));
          },
          child: Icon(Icons.add)),
      appBar:AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) {
                    return loginpage();
                  },
                ));
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: () {
                getProfile(id);
              },
              child: Icon(Icons.person, size: 30),
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          'OSKUN',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      )
      ,
      backgroundColor: Colors.white.withOpacity(1),
      body: Center(child: _widget()),
    );
  }
  Widget _widget(){
    if(list.length == null || list.length<=0){
      return  CircularProgressIndicator();

    }
    else {
      return  Container(
        child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min,children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white60.withOpacity(1),
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                hintText: 'Search here...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
                // perform search based on searchText value
              },
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              SizedBox(
                width: 35,
              ),
              Text(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  'Recently Added')
            ],
          ),
          SizedBox(height: 30),
          SizedBox(
            height: 250,
            child: ListView.separated(
                separatorBuilder: (BuildContext, int i) {
                  return SizedBox(width: 10);
                },
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, int i) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return details(id: list[i].id!,userId: id!);
                            }));
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 250,
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
                                      height: 150,
                                      width: 300,
                                      '${list[i].mainImage}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),


                                  Text(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.bed),
                                            Text(
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold),
                                                '${list[i].bedsNumber} beds')
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 10, left: 10),
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.bathtub),
                                            Text(
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                              '${list[i].bathsNumber} baths',overflow: TextOverflow.ellipsis,)
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.fullscreen_outlined),
                                            Text(
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold),
                                                '${list[i].size}')
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
                              children: [
                                Icon(
                                    size: 15,
                                    color: Colors.black,
                                    Icons.location_on),
                                Text(
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    '${list[i].location}'),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white60),
                              margin: EdgeInsets.only(top: 6, left: 220),
                              child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: Icon(size: 20, Icons.favorite_border)))
                          ,Container(margin: EdgeInsets.only(top: 153,left: 200),
                            child: Row(children: [ Icon(color: Colors.yellow, Icons.star),
                              Text(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                  '${list[i].rating}')

                              ,],),
                          )],
                      ));
                }),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 35,
              ),
              Text(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  'Featured Listings'),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: ListView.separated(physics: NeverScrollableScrollPhysics(),shrinkWrap: true ,
                separatorBuilder: (BuildContext, int i) {
                  return SizedBox(width: 10);
                },

                itemCount: list.length-3,
                itemBuilder: (context, int i) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return details(id: list[i + 3].id!,userId: id!);
                            }));
                      },
                      child:Stack(
                        children: [
                          Container(
                            height: 300,
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
                                      '${list[i + 3].mainImage}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),


                                      Text(
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                          '${list[i + 3] .name}'),



                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2475EC)),
                                      "\$${list[i + 3 ].price}"),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 10,
                                        ),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.bed),
                                            Text(
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold),
                                                '${list[i + 3 ].bedsNumber} beds')
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: 10, left: 45, right: 40),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.bathtub),
                                            Text(
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold),
                                                '${list[i + 3].bathsNumber} baths')
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10, left: 3),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.fullscreen_outlined),
                                            Text(
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold),
                                                '${list[i + 3 ].size}m')
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
                            child: Row(mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                    size: 15,
                                    color: Colors.black,
                                    Icons.location_on),
                                Text(
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    '${list[i + 3 ].location}'),
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
                                  child: Icon(size: 20, Icons.favorite_border)))
                        ,Container(margin: EdgeInsets.only(left: 320,top: 205),
                          child: Row(children: [  Icon(color: Colors.yellow, Icons.star),
                              Text(
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  '${list[i + 3 ].rating}')
                              ,],),
                        )],
                      ));
                }),
          )


        ])),
      );
    }
  }
  @override
  void initState() {

    getHouse();
    getData();



  }
  getData() async{
    String? token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    Map<String, dynamic>? decodedToken = Jwt.parseJwt(token ?? '');
    if (decodedToken != null) {
      setState(() {
        id = decodedToken['id'];

      });
      print('----------------------------------------------');
      print(decodedToken);
      print(id);
      print('------------------------------------------');
    }
    else{
      print('----------------------------------------------');
      print('Error');
      print('------------------------------------------');
    }


  }

  Future<void> getHouse() async{http.Response response = await http.get(Uri.parse(
      'http://api.bluelightlms.com/AvailableHouses'));
  Map<String, dynamic> map = json.decode(response.body);
  String message = map['message'];
  List data= map['data'];
  print(data[1]);
  setState(() {
    for (i = 0; i < data.length; i++) {
      availhomes AvailHomes =  availhomes.fromjson(data[i]);
      list.add(AvailHomes);
    }
  });

  }
  Future<void> getProfile(int? id) async {
    final http.Response response = await http.get(
      Uri.parse('http://api.bluelightlms.com/profile?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return ProfilePage(id:id! , email: email!,image: image!,name: name!,);
        }));

    try {
      Map<String, dynamic> map = json.decode(response.body);
      setState(() {
        String? message = map['message'];
        Map<String, dynamic> map2 = map['data'];
        name= map2['name'];
        email = map2['email'];
        image = map2['imgDir'];
      });



      print('Response status code: ${response.statusCode}');

    } catch (e) {
      print('Error parsing JSON: $e');
      print('Response body: ${response.body}');
    }
  }




}
class availhomes {
  String? name;
  String? location;
  int? bedsNumber;
  int? bathsNumber;
  String? mainImage;
  double? rating;
  int? size;
  int? price;
  int? id;
  availhomes.fromjson(Map<String, dynamic> data) {
    name= data['name'];
    location= data['location'];
    bedsNumber = data['beds'];
    bathsNumber = data['baths'];
    mainImage= data['mainImg'];
    rating = data['rating'];
    size =data['size'];
    price= data['price'];
    id = data['id'];




  }
}
