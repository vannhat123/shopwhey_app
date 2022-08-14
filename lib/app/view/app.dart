import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopwhey_app_2022/app/app.dart';
import 'package:shopwhey_app_2022/constants/constants.dart';
import 'package:shopwhey_app_2022/constants/theme.dart';

import '../../providers/providers.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget{
  const AppView({super.key});
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
    await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: FlowBuilder<AppStatus>(
       state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }


}
