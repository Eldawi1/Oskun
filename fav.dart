import 'package:flutter/material.dart';
import 'class.dart';
import 'HomePgae.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // adding color to app bar
        centerTitle: true, // centering the title
        title: Text(
          'Favorite',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 0, // replace with your own list of items
            itemBuilder: (context, index) {
              return ListTile(
                // replace with your own date/time information
              );
            },
          ),
          Center(
            child: Opacity(
              opacity: 0.2, // set the desired opacity for the icon
              child: Icon(
                Icons.favorite_sharp,
                size: 250, // set the desired size for the icon
              ),
            ),
          ),
        ],
      ),
    );
  }
}