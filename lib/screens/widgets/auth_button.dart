import 'package:flutter/material.dart';
import 'package:shopwhey_app_2022/screens/widgets/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.fct,
    required this.buttonText,
    required this.primary ,
  }) : super(key: key);
  final Function fct;
  final String buttonText;
  final Color primary;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary, // background (button) color
          ),
          onPressed: () {
            fct();
            // _submitFormOnLogin();
          },
          child: Text(buttonText,style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
    );
  }
}