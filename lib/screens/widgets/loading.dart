import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class Loading extends StatelessWidget {
  String? title;
  Loading({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(
          color: Colors.white70,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: MyColors.primary,
              borderRadius: BorderRadius.circular(10.0)),
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          alignment: AlignmentDirectional.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Center(
                child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(
                    value: null,
                    strokeWidth: 7.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Text(
                    title ?? '',
                    style:  TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
