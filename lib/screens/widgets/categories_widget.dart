import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopwhey_app_2022/screens/widgets/text_widget.dart';

import '../../providers/dark_theme_provider.dart';


class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {Key? key,
      required this.catText,
      required this.imgPath,
      required this.passedColor})
      : super(key: key);
  final String catText, imgPath;
  final Color passedColor;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
      },
      child: Container(
        // height: _screenWidth * 0.6,
        decoration: BoxDecoration(
          color: passedColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: passedColor.withOpacity(0.7),
            width: 2,
          ),
        ),
        child: Column(children: [
          // Container for the image
          Container(
            height: _screenWidth * 0.3,
            width: _screenWidth * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    imgPath,
                  ),
                  fit: BoxFit.fill),
            ),
          ),
          // Category name
          TextWidget(
            text: catText,
            color: Colors.green,
            textSize: 20,
            isTitle: true,
          ),
        ]),
      ),
    );
  }
}
