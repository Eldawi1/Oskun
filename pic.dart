import 'package:flutter/material.dart';

class picture extends StatelessWidget {
  const picture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: InteractiveViewer(

                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                      fit: BoxFit.fitWidth,
                      height: 2000,
                      'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%A3%D8%AD%D8%AF%D8%AB-%D8%AF%D9%8A%D9%83%D9%88%D8%B1%D8%A7%D8%AA-%D8%B4%D9%82%D9%82-2023-1.jpg'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
