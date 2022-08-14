import 'package:flutter/material.dart';

import '../services/utils.dart';
import '../widgets/categories_widget.dart';
import '../widgets/text_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/categories/fruits.png',
      'catText': 'Fruits',
    },
    {
      'imgPath': 'assets/categories/veg.png',
      'catText': 'Vegetables',
    },
    {
      'imgPath': 'assets/categories/Spinach.png',
      'catText': 'Herbs',
    },
    {
      'imgPath': 'assets/categories/nuts.png',
      'catText': 'Nuts',
    },
    {
      'imgPath': 'assets/categories/spices.png',
      'catText': 'Spices',
    },
    {
      'imgPath': 'assets/categories/grains.png',
      'catText': 'Grains',
    },
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Các loại thực phẩm',
            color: Colors.red,
            textSize: 24,
            isTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 250,
            crossAxisSpacing: 10, // Vertical spacing
            mainAxisSpacing: 10, // Horizontal spacing
            children: List.generate(6, (index) {
              return CategoriesWidget(
                catText: catInfo[index]['catText'],
                imgPath: catInfo[index]['imgPath'],
                passedColor: gridColors[index],
              );
            }),
          ),
        ));
  }
}
