import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shopwhey_app_2022/constants/constants.dart';
import 'package:shopwhey_app_2022/screens/google_button.dart';

import '../../services/global_methods.dart';
import '../../signup/view/sign_up_page.dart';
import '../../widgets/auth_forget_pass.dart';
import '../../widgets/text_widget.dart';
import '../cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              );
          }
        },
        child: SafeArea(
            child: Stack(
          children: [
            // landing ground move
            Swiper(
              duration: 800,
              autoplayDelay: 8000,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constss.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: Constss.authImagesPaths.length,
            ),
            Container(
              color: MyColors.primary.withOpacity(0.3),
            ),
            ListView(
              children: [
                Container(
                  height: getHeight(800),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 1,
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          _EmailInput(),
                          const SizedBox(height: 8),
                          const PasswordInput(),
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                GlobalMethods.navigateTo(
                                    ctx: context,
                                    function: const ForgetPasswordScreen(), routeName: null);
                              },
                              child: const Text(
                                'Quên mật khẩu?',
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _LoginButton(),
                          const SizedBox(height: 8),
                          const GoogleButton(),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 2,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              TextWidget(
                                text: 'Hoặc',
                                color: Colors.white,
                                textSize: 18,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Expanded(
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),
                          _RegisterButton()
                        ],
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color: Colors.white, fontSize: 15),
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white, fontSize: 15),
            labelText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatefulWidget{
  const PasswordInput({super.key});

  @override
  _PasswordInputState createState()=> _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var _obscureText =true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color: Colors.white, fontSize: 15),
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white, fontSize: 15),
            labelText: 'password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white,
                )),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primary.withOpacity(0.9), // background (button) color
                    ),
                    onPressed: (){
                      if(state.status.isValidated){
                        context.read<LoginCubit>().logInWithCredentials();
                      }
                    },
                    child: TextWidget(
                      text: "Đăng nhập",
                      textSize: 18,
                      color: Colors.white,
                    )),
              );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.9), // background (button) color
              ),
              onPressed: (){
                Navigator.of(context)
                    .push<void>(SignUpPage.route());
              },
              child: TextWidget(
                text: "Đăng ký",
                textSize: 18,
                color: Colors.white,
              )),
        );
      },
    );
  }
}


