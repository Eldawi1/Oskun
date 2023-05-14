import 'package:flutter/material.dart';
import 'class.dart';

class RepeatWidget extends StatelessWidget {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return classs(
            name: 'borg',
            area: 20,
            location: 'elborg',
            price: 3200,
            baths: 2,
            beds: 5,
            image:
                'https://www.mexatk.com/wp-content/uploads/2021/12/%D8%AF%D9%8A%D9%83%D9%88%D8%B1-%D8%B4%D9%82%D9%82-2023-1.jpg');
      }),
    );
  }
}
