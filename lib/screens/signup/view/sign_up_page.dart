import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopwhey_app_2022/screens/signup/view/sign_up_form.dart';

import '../cubit/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
          child: const SignUpForm(),
        ),
    );
  }
}
