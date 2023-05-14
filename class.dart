import 'package:flutter/material.dart';
import 'details.dart';
import 'HomePgae.dart';

class classs extends StatefulWidget {
  final String? image;
  final String? location;
  final String? name;
  final int? beds;
  final int? baths;
  final double? area;
  final double? price;

  const classs({
    Key? key,
    required this.image,
    required this.name,
    required this.location,
    required this.beds,
    required this.baths,
    required this.area,
    required this.price,
  }) : super(key: key);

  @override
  State<classs> createState() => _classsState();
}

class _classsState extends State<classs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {

            },
            child: Stack(
              children: [
                Container(
                  height: 300,
                  width: 350,
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
                            '${widget.image}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                '${widget.name}'),
                            SizedBox(width: 200),
                            Icon(color: Colors.yellow, Icons.star),
                            Text(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                '4.6')
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2475EC)),
                            "${widget.price}"),
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
                                      '${widget.beds}')
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
                                      '${widget.baths}')
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
                                      '${widget.area}')
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
                  width: 160,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(left: 5, top: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white60),
                  child: Row(
                    children: [
                      Icon(size: 15, color: Colors.black, Icons.location_on),
                      Text(
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          '${widget.location}'),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white60),
                    margin: EdgeInsets.only(top: 6, left: 320),
                    child: GestureDetector(
                        onTap: () {},
                        child: Icon(size: 20, Icons.favorite_border)))
              ],
            )),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
