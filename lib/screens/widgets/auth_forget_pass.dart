import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopwhey_app_2022/screens/widgets/header.dart';
import 'package:shopwhey_app_2022/screens/widgets/text_widget.dart';

import '../../constants/constants.dart';
import '../loadingmanager/loading_manager.dart';
import '../services/services.dart';
import 'auth_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();

  // bool _isLoading = false;
  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  bool _isLoading = false;

  void _forgetPassFCT() async {
    if (_emailTextController.text.isEmpty ||
        !_emailTextController.text.contains("@")) {
      GlobalMethods.errorDialog(
          subtitle: 'Vui lòng nhập địa chỉ email chính xác', context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: _emailTextController.text.toLowerCase());
        Fluttertoast.showToast(
          msg: "Một email đã được gửi đến địa chỉ email của bạn",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: LoadingManager(
          isLoading: _isLoading,
          child: SafeArea(
            child: Stack(
              children: [
                Swiper(
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
                  color: MyColors.primary.withOpacity(0.25),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        leftIcon: MyIcons.back,
                        onPressLeftIcon: () {
                          Navigator.pop(context);
                        },
                        rightIcon: MyIcons.menu,
                        onPressRightIcon: () => null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Quên mật khẩu',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _emailTextController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Địa chỉ email',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AuthButton(
                        buttonText: 'Đổi lại ngay',
                        fct: () {
                          _forgetPassFCT();
                        },
                        primary: MyColors.primary.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
