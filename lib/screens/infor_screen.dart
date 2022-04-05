import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logindemo/models/infor_model.dart';
import 'package:logindemo/screens/login_screen.dart';
import 'package:logindemo/services/remote_service.dart';
import 'package:logindemo/sharedpreference/sharedpreference.dart';
import 'package:logindemo/widget/tab_infor.dart';
import 'package:logindemo/widget/tab_map_1.dart';
import 'package:logindemo/widget/tab_test.dart';
import 'package:logindemo/widget/tab_test_header.dart';

class InforScreen extends StatefulWidget {
  const InforScreen({Key? key}) : super(key: key);

  @override
  State<InforScreen> createState() => _InforScreenState();
}

class _InforScreenState extends State<InforScreen> {
  InforModel infor = InforModel();
  bool checkDataLoading = false;

  checkToken() async {
    String? _res = await SharedPreferenceClass.getString('user_token');

    if (_res == null) {
      Get.off(LoginScreen());
    } else {
      final data = await RemotesServices.fetchInfor(_res);
      setState(() {
        infor = data;
        checkDataLoading = true;
      });
    }
  }

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkToken();
    new Future.delayed(
      const Duration(seconds: 3),
      () => print('3s passed'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabItems = [
      TabInfor(checkDataLoading: checkDataLoading, infor: infor),
      TabMap1(),
      TabTestHeader(),
    ];
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Color.fromARGB(255, 249, 140, 132),
            animationDuration: Duration(milliseconds: 400),
            animationCurve: Curves.ease,
            items: [
              Icon(Icons.add, size: 30),
              Icon(Icons.list, size: 30),
              Icon(Icons.compare_arrows, size: 30),
            ],
            onTap: (index) {
              setState(() {
                _page = index;
              });
              //Handle button tap
            },
            letIndexChange: (index) => true,
          ),
          body: _tabItems[_page],
        ),
      ),
    );
  }
}
