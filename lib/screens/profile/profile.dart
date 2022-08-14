import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopwhey_app_2022/constants/constants.dart';
import 'package:shopwhey_app_2022/screens/widgets/auth_forget_pass.dart';
import '../../app/bloc/app_bloc.dart';
import '../services/global_methods.dart';
import '../widgets/text_widget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  final _textNameController = TextEditingController();
  final _textAddressController = TextEditingController();
  final _textAgeController = TextEditingController();
  final _textPhoneController = TextEditingController();
  final random = Random();
  late int valueRandom = random.nextInt(1000);


  final List<String?> errors = [];
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }


  Future<void> _add(var email) async {
    final CollectionReference profileAdd =
        FirebaseFirestore.instance.collection(email);
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return ListView(
            children: [
              Container(
                  color: MyColors.primary,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          controller: _textNameController,
                          decoration: const InputDecoration(
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            labelText: "name",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          controller: _textAgeController,
                          decoration: const InputDecoration(
                            labelText: "age",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          controller: _textAddressController,
                          decoration: const InputDecoration(
                            labelText: "address",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          controller: _textPhoneController,
                          decoration: const InputDecoration(
                            labelText: "phone",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.green;
                                  }
                                  return Colors
                                      .white; // Use the component's default.
                                },
                              ),
                            ),
                            child: const Text(
                              "Tạo",
                              style: TextStyle(
                                  color: MyColors.primary, fontSize: 20),
                            ),
                            onPressed: () async {
                              final String name = _textNameController.text;
                              final String age = _textAgeController.text;
                              final String address =
                                  _textAddressController.text;
                              final String phone = _textPhoneController.text;

                              if (name != null &&
                                  phone != null &&
                                  address != null &&
                                  age != null) {
                                await profileAdd.doc(email).set({
                                  'name': name,
                                  'age': age,
                                  'address': address,
                                  'phone': phone,
                                  'account': "1255${valueRandom.toString()}",
                                  'email': email,
                                  'balance': 500000
                                });
                                _textNameController.text = '';
                                _textAgeController.text = '';
                                _textAddressController.text = '';
                                _textPhoneController.text = '';
                                // Hide the bottom sheet
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final CollectionReference profile =
        FirebaseFirestore.instance.collection(user.email!);
    return SafeArea(
           child: Container(
             color: Colors.white,
             child: StreamBuilder<QuerySnapshot>(
                 stream: profile.snapshots(),
                 builder: (
                     BuildContext context,
                     AsyncSnapshot<QuerySnapshot> snapshot,
                     ) {
                   if (snapshot.hasError) {
                     return const Text("Something went wrong");
                   }
                   if (snapshot.connectionState == ConnectionState.waiting) {
                     return const SizedBox(
                         width: 100,
                         height: 100,
                         child: Center(
                           child: CircularProgressIndicator(),
                         ));
                   }
                   try {
                     final DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
                     final data = snapshot.requireData;
                     return Container(
                       padding: const EdgeInsets.all(20),
                       child: ListView(
                         children: [
                           Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 RichText(
                                   text: TextSpan(
                                     text: "Hi, ",
                                     style: const TextStyle(
                                       color: MyColors.primary,
                                       fontSize: 27,
                                       fontWeight: FontWeight.bold,
                                     ),
                                     children: <TextSpan>[
                                       TextSpan(
                                           text: '${data.docs[0]["name"]}',
                                           style: const TextStyle(
                                             color: Colors.black,
                                             fontSize: 27,
                                             fontWeight: FontWeight.w600,
                                           ),
                                           recognizer: TapGestureRecognizer()
                                             ..onTap = () {
                                               print('My name is pressed');
                                             }),
                                     ],
                                   ),
                                 ),
                                 Text(
                                   user.email!,
                                   style: const TextStyle(
                                       fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                 ),
                                 const SizedBox(
                                   height: 7,
                                 ),
                                 const Divider(
                                   thickness: 1,
                                 ),
                                 SizedBox(
                                     child: Column(
                                       children: [
                                         _listTiles(
                                           title: 'Địa chỉ',
                                           subtitle: "${data.docs[0]["address"]}",
                                           icon: IconlyLight.profile,
                                           onPressed: () async {
                                             _showAddressDialog(documentSnapshot, "address", user.email,
                                             );
                                           },
                                         ),
                                         _listTiles(
                                           title: 'Đơn hàng',
                                           icon: IconlyLight.bag,
                                           onPressed: () {
                                             _alertDialog();
                                           },
                                         ),
                                         _listTiles(
                                           title: 'Yêu thích',
                                           icon: IconlyLight.heart,
                                           onPressed: () {
                                             _alertDialog();
                                           },
                                         ),
                                         _listTiles(
                                           title: 'Đã xem',
                                           icon: IconlyLight.show,
                                           onPressed: () {
                                             _alertDialog();
                                           },
                                         ),
                                         _listTiles(
                                           title: 'Lịch sử',
                                           icon: IconlyLight.buy,
                                           onPressed: () {
                                             _alertDialog();
                                           },
                                         ),
                                         _listTiles(
                                           title: 'Đổi mật khẩu',
                                           icon: IconlyLight.unlock,
                                           onPressed: () {
                                             Navigator.push(context, MaterialPageRoute(builder:(_)=> const ForgetPasswordScreen()));
                                           },
                                         ),
                                         _listTiles(
                                           title: "Thoát",
                                           icon: IconlyLight.logout,
                                           onPressed: () {
                                             GlobalMethods.warningDialog(
                                                 title: 'Thoát ',
                                                 subtitle: 'Bạn có muốn thoát không',
                                                 fct: () {
                                                   context
                                                       .read<AppBloc>()
                                                       .add(AppLogoutRequested());
                                                 },
                                                 context: context);
                                           },
                                         ),
                                       ],
                                     )),
                               ])
                         ],
                       ),
                     );
                   } catch (e) {
                     return Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           const Text(
                             "Vui lòng nhập \n thông tin cá nhân",
                             textAlign: TextAlign.center,
                             style: TextStyle(
                                 color: MyColors.primary,
                                 fontSize: 27,
                                 fontWeight: FontWeight.bold),
                           ),
                           const SizedBox(
                             height: 20,
                           ),
                           ElevatedButton(
                             style: ButtonStyle(
                               backgroundColor:
                               MaterialStateProperty.resolveWith<Color>(
                                     (Set<MaterialState> states) {
                                   if (states.contains(MaterialState.hovered)) {
                                     return Colors.green;
                                   }
                                   return MyColors
                                       .primary; // Use the component's default.
                                 },
                               ),
                             ),
                             onPressed: () {
                               _add(user.email);
                             },
                             child: const Text(
                               "Tạo mới",
                               style: TextStyle(color: Colors.white, fontSize: 20),
                             ),
                           ),
                           ElevatedButton(
                             style: ButtonStyle(
                               backgroundColor:
                               MaterialStateProperty.resolveWith<Color>(
                                     (Set<MaterialState> states) {
                                   if (states.contains(MaterialState.hovered)) {
                                     return Colors.green;
                                   }
                                   return MyColors.primary.withOpacity(
                                       0.5); // Use the component's default.
                                 },
                               ),
                             ),
                             onPressed: () {
                               context.read<AppBloc>().add(AppLogoutRequested());
                             },
                             child: const Text(
                               "Thoát",
                               style: TextStyle(color: Colors.white, fontSize: 20),
                             ),
                           )
                         ]);
                   }
                 }),
           )
    );
  }

  Future<void> _alertDialog() async{
    await showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            backgroundColor: MyColors.primary,
            content:
             Text(" Chưa hoàn thành",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
            )
          );
        });
  }


  Future<void> _showAddressDialog(DocumentSnapshot? documentSnapshot, var valueConfig, var email) async {
    _textAddressController.text = documentSnapshot![valueConfig];
    final CollectionReference profileUpdate =
    FirebaseFirestore.instance.collection(email);
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Địa Chỉ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
            content: TextFormField(
              style: const TextStyle(color: MyColors.primary, fontSize: 20),
              controller: _textAddressController,
              decoration: InputDecoration(
                labelStyle:
                const TextStyle(color: Colors.white, fontSize: 18),
                labelText: valueConfig,
                border: const UnderlineInputBorder(),
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.green;
                        }
                        return MyColors.green.withOpacity(
                            0.8); // Use the component's default.
                      },
                    ),
                  ),
                  child: const Text("Thay đổi",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                  onPressed: () async {
                    String name = _textAddressController.text;
                    if (name.length >4) {
                      await profileUpdate
                          .doc(documentSnapshot.id)
                          .update({valueConfig: name});
                      _textAddressController.text = '';
                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                ),
              )
            ],
          );
        });
        }
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    Color color = Colors.black,
  }) {
    return ListTile(
      title: Text(
        "$title   ${subtitle ?? ""}",
        style: TextStyle(color: color,fontWeight: FontWeight.bold,fontSize: 20),
      ),

      leading: Icon(icon, color: Colors.black,),
      trailing: const Icon(IconlyLight.arrowRight2,color: Colors.black,),
      onTap: () {
        onPressed();
      },
    );
}
