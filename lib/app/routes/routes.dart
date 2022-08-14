import 'package:flutter/widgets.dart';
import 'package:shopwhey_app_2022/app/bloc/app_bloc.dart';
import 'package:shopwhey_app_2022/screens/app_tab/app_tap.dart';
import 'package:shopwhey_app_2022/screens/login/view/login_page.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [AppTab.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
