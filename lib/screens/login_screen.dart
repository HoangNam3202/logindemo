import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logindemo/screens/infor_screen.dart';
import 'package:logindemo/services/remote_service.dart';
import 'package:logindemo/sharedpreference/sharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameInput = TextEditingController(text: 'usertest32@gmail.com');
  final passwordInput = TextEditingController(text: 'AbcDef123');
  bool checkSubmit = false;

  checkToken() async {
    String? _res = await SharedPreferenceClass.getString('user_token');
    if (_res != null) {
      final dataCheck = await RemotesServices.fetchInfor(_res);
      if (dataCheck.email != null) {
        Get.off(InforScreen());
      }
    } else {
      print('SharedPreference null');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          controller: nameInput,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is empty !';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'UserName',
                            hintText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: passwordInput,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is empty !';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              suffixIcon: Icon(Icons.remove_red_eye_sharp)),
                        ),
                        checkSubmit == false
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        checkSubmit = true;
                                      });
                                      String code =
                                          await RemotesServices.fetchLogin(
                                        nameInput.text,
                                        passwordInput.text,
                                      );
                                      print(code);
                                      setState(() {
                                        checkSubmit = false;
                                      });
                                      if (code != 'null') {
                                        Get.off(InforScreen());
                                        SharedPreferenceClass.putString(
                                            'user_token', code);
                                      } else {
                                        const snackBar = SnackBar(
                                          content: Text(
                                              'Wrong Username or Password !'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }
                                  },
                                  child: const Text('Submit'),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 10.0,
                                ),
                                child: SizedBox(
                                  height: 15.0,
                                  width: 15.0,
                                  child: Transform.scale(
                                    scale: 2,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
