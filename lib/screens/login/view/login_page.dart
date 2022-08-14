import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child: const LoginForm(),
        ),
    );
  }
}
