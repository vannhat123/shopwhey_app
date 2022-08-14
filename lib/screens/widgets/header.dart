import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class Header extends StatelessWidget {
  final leftIcon;
  final onPressLeftIcon;

  final rightIcon;
  final onPressRightIcon;

  String? title;

  Header({
    Key? key,
    this.leftIcon,
    this.rightIcon,
    this.onPressLeftIcon,
    this.onPressRightIcon,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftIcon == null ?
          const SizedBox(
            width: 50,
            height: 50,
          ) :
          InkWell(
            onTap: onPressLeftIcon,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: leftIcon,
                fit: BoxFit.cover,
                width: 20,
                height: 20,
                color: MyColors.white,
              ),
            ),
          ),
          Text(title ?? '',style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          rightIcon == null ?
          const SizedBox(
            width: 50,
            height: 50,
          ) : InkWell(
            onTap: onPressRightIcon,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: rightIcon,
                fit: BoxFit.cover,
                width: 20,
                height: 20,
                color: MyColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
