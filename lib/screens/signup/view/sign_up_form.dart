import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shopwhey_app_2022/screens/login/login.dart';
import '../../../constants/constants.dart';
import '../../widgets/text_widget.dart';
import '../cubit/sign_up_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.primary,
        elevation: 0.0,
        title: const Text('Đăng ký ứng dụng',style: TextStyle(color: Colors.white,fontSize: 16)),
        actions: <Widget>[
          TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder:(_)=> const LoginPage()));
              },
              icon: const Icon(Icons.person, color: Colors.white,),
              label: const Text('Đăng nhập',style: TextStyle(color: Colors.white,fontSize: 14),))
        ],
      ) ,
        backgroundColor: MyColors.primary,
        body: BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state.status.isSubmissionSuccess) {
                Navigator.of(context).pop();
              } else if (state.status.isSubmissionFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                        content: Text(state.errorMessage ?? 'Đăng ký thất bại')),
                  );
              }
            },
            child: SafeArea(
              child: Stack(children: [
                Swiper(
                  duration: 800,
                  autoplayDelay: 6000,

                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      Constss.authImagesPaths[index],
                      fit: BoxFit.cover,
                    );
                  },
                  autoplay: true,
                  itemCount: Constss.authImagesPaths.length,

                  // control: const SwiperControl(),
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
                          Column(
                            children: [
                              _EmailInput(),
                              const SizedBox(height: 8),
                              const PasswordInput(),
                              const SizedBox(height: 8),
                              const ConfirmPasswordInput(),
                              const SizedBox(height: 8),
                              _SignUpButton(),
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
              ]),
            )));
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color: Colors.white, fontSize: 16),
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) {
            context.read<SignUpCubit>().emailChanged(email);
          },
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

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color: Colors.white, fontSize: 16),
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
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
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                )),
          ),
        );
      },
    );
  }
}

class ConfirmPasswordInput extends StatefulWidget {
  const ConfirmPasswordInput({super.key});

  @override
  _ConfirmPasswordInputState createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<ConfirmPasswordInput> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color: Colors.white, fontSize: 16),
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white, fontSize: 15),
            labelText: 'confirm password',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'passwords do not match'
                : null,
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
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                )),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // background (button) color
                    ),
                    onPressed: () async => {
                          state.status.isValidated
                              ? context.read<SignUpCubit>().signUpFormSubmitted()
                              : null
                        },
                    child: TextWidget(
                      text: "Đăng ký ngay",
                      textSize: 18,
                      color: Colors.white,
                    )),
              );
      },
    );
  }
}
