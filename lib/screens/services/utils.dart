import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';


class Utils {
  BuildContext context;
  Utils(this.context);
  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get color => getTheme ? Colors.white : Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size;
}
