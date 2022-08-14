import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shopwhey_app_2022/constants/constants.dart';
import 'package:shopwhey_app_2022/models/profilemodel.dart';
import 'package:shopwhey_app_2022/repositories/user_repository.dart';
import 'package:shopwhey_app_2022/screens/app_tab/app_tap.dart';
import 'package:shopwhey_app_2022/screens/login/view/login_page.dart';
import 'package:shopwhey_app_2022/screens/signup/sign_up.dart';

import '../../app/bloc/app_bloc.dart';
import '../widgets/header.dart';

class ProfileConfig extends StatefulWidget {
  static String routeName = "profileconfig";

  ProfileConfig({Key? key}) : super(key: key);

  @override
  _ProfileConfigState createState() => _ProfileConfigState();
}

class _ProfileConfigState extends State<ProfileConfig> {
  final _formKey = GlobalKey<FormState>();
  ProfileModel profileModel = ProfileModel(
      name: "", address: "", age: "", phone: "", numberAccount: '', balance: 0);
  UserRepository userRepository = UserRepository();
  final _textNameController = TextEditingController();
  final _textAddressController = TextEditingController();
  final _textAgeController = TextEditingController();
  final _textPhoneController = TextEditingController();
  final random = Random();
  late int valueRandom;

  @override
  void initState() {
    super.initState();
    valueRandom = random.nextInt(1000);
    profileModel.numberAccount = "1255${valueRandom.toString()}";
    _textNameController.text = profileModel.name;
    _textAddressController.text = profileModel.address;
    _textAgeController.text = profileModel.age;
    _textPhoneController.text = profileModel.phone;
  }

  @override
  void dispose() {
    super.dispose();
    _textPhoneController.dispose();
    _textAgeController.dispose();
    _textAddressController.dispose();
    _textNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final CollectionReference profile = FirebaseFirestore.instance.collection(user.email!);
    return Scaffold(
      backgroundColor: MyColors.primary,
       body:  SafeArea(
         child: Form(
             key: _formKey,
             child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: ListView(
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Header(
                           leftIcon: MyIcons.back,
                           onPressLeftIcon: () {
                             Navigator.pop(context);
                           },
                           rightIcon: MyIcons.menu,
                           onPressRightIcon: () => null,
                           title: "Đăng Nhập",
                         ),
                         Container(
                           padding: const EdgeInsets.symmetric(vertical: 50),
                           height: 150,
                           child: const Center(
                             child: Icon(Icons.camera_alt, size: 100, color: Colors.white),
                           ),
                         ),
                         const SizedBox(height: 10,),
                         TextFormField(
                           style: const TextStyle(color: Colors.white, fontSize: 20),
                           controller: _textNameController,
                           decoration: const InputDecoration(
                               enabledBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.white),
                               ),
                               labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                               hintStyle: TextStyle(color: Colors.white70),
                               hintText: 'Tên bạn là gì?',
                               labelText: 'Tên'),
                           onChanged: (value) {
                             if (value.isNotEmpty) {
                               profileModel.name = value;
                             }
                           },
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter some text';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(
                           height: 5,
                         ),
                         TextFormField(
                           style: const TextStyle(color: Colors.white, fontSize: 20),
                           controller: _textAddressController,
                           decoration: const InputDecoration(
                               enabledBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.white),
                               ),
                               labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                               hintStyle: TextStyle(color: Colors.white70),
                               hintText: 'Địa chỉ của bạn?',
                               labelText: 'Địa chỉ'),
                           onChanged: (value) {
                             if (value.isNotEmpty) {
                               profileModel.address = value;
                             }
                           },
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter some text';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(
                           height: 5,
                         ),
                         TextFormField(
                           style: const TextStyle(color: Colors.white, fontSize: 20),
                           controller: _textAgeController,
                           decoration: const InputDecoration(
                               enabledBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.white),
                               ),
                               labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                               hintStyle: TextStyle(color: Colors.white70),
                               hintText: 'Bạn bao nhiêu tuổi?',
                               labelText: 'Tuổi'),
                           onChanged: (value) {
                             if (value.isNotEmpty) {
                               profileModel.age = value;
                             }
                           },
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter some text';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(
                           height: 5,
                         ),
                         TextFormField(
                           style: TextStyle(color: Colors.white, fontSize: 20),
                           controller: _textPhoneController,
                           decoration: const InputDecoration(
                               enabledBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.white),
                               ),
                               labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                               hintStyle: TextStyle(color: Colors.white70),
                               hintText: 'Số điện thoại của bạn?',
                               labelText: 'Điện thoại'),
                           onChanged: (value) {
                             if (value.isNotEmpty) {
                               profileModel.phone = value;
                             }
                           },
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter some text';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(
                           height: 25,
                         ),
                         Center(
                             child: Button(
                               text: "Hoàn Thành",
                               press: () {
                                 if (_formKey.currentState!.validate()) {
                                   const SnackBar(
                                     content: Text("Sending data to cloud Firestore"),
                                   );
                                   profile.doc(user.email).set({
                                     'name': profileModel.name,
                                     'age': profileModel.age,
                                     'address': profileModel.address,
                                     'phone': profileModel.phone,
                                     'account': profileModel.numberAccount,
                                     'email': user.email,
                                     'balance': 0
                                   })
                                       .then((value) => context.read<SignUpCubit>().signUpProfileSubmitted())
                                       .catchError(
                                           (error) => print("Failed to add user: $error"));
                                   Navigator.push(context, MaterialPageRoute(builder:(_)=> AppTab()));
                                 }
                               },
                               colorButtonText: MyColors.primary,
                               colorBackGroundButton: Colors.white,
                             ))
                       ],
                     ),
                   ],
                 )
             )),
       ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.text,
    this.press,
    this.colorButtonText,
    this.colorBackGroundButton,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final Color? colorButtonText;
  final Color? colorBackGroundButton;
  static const IconData arrow_forward =
      IconData(0xe09b, fontFamily: 'MaterialIcons', matchTextDirection: true);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 70,
        child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              primary: Colors.black,
              backgroundColor: colorBackGroundButton!,
              side: const BorderSide(color: Colors.indigoAccent),
            ),
            onPressed: press as void Function()?,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    text!,
                    style: TextStyle(
                        color: colorButtonText!,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ))));
  }
}

Future<void> _create() async {
  await FirebaseFirestore.instance
      .collection('profile')
      .doc("10")
      .set({'firstName': "nhat"});
}

