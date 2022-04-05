import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logindemo/models/infor_model.dart';
import 'package:logindemo/screens/login_screen.dart';
import 'package:logindemo/sharedpreference/sharedpreference.dart';

class TabInfor extends StatefulWidget {
  const TabInfor(
      {Key? key, required this.checkDataLoading, required this.infor})
      : super(key: key);
  final bool checkDataLoading;
  final InforModel infor;
  @override
  State<TabInfor> createState() => _TabInforState();
}

class _TabInforState extends State<TabInfor> {
  @override
  Widget build(BuildContext context) {
    return widget.checkDataLoading == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${widget.infor.email}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${widget.infor.firstname}'),
                  Text('${widget.infor.lastname}'),
                ],
              ),
              Text('${widget.infor.dob}'),
              ElevatedButton(
                onPressed: () {
                  Get.off(LoginScreen());
                  SharedPreferenceClass.deleteString('user_token');
                },
                child: Text('Logout'),
              )
            ],
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                CircularProgressIndicator(
                  strokeWidth: 10,
                ),
              ],
            ),
          );
  }
}
