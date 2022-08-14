import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/bloc_observer.dart';
import 'app/view/app.dart';


Future<void> main() async {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.user.first;
      runApp(MaterialApp(
        home: App(authenticationRepository: authenticationRepository),
          debugShowCheckedModeBanner: false,
      ));
    },
    blocObserver: AppBlocObserver(),
  );
}
