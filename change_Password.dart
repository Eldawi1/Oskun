import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'signin.dart';

class password extends StatefulWidget {
  final String? email;
  const password({Key? key, required this.email}) : super(key: key);

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
  String? password;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> KEY = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'OSKUN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      )
                    ],
                  )),
                  color: Colors.indigoAccent)),
          Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Form(
                key: KEY,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(height: 50),
                            Padding(
                              padding: EdgeInsets.only(right: 230, bottom: 8),
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                  'Password'),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 50, left: 50),
                                child: TextFormField(
                                  onChanged: (value) { password = value;},
                                  controller: passwordController,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.length < 6) {
                                      return 'password must be more than 6';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: 'Enter your password',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                )),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(right: 188, bottom: 8),
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                  'Confirm Password'),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 50, left: 50),
                                child: TextFormField(
                                  controller: confirmPasswordController,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.length < 6) {
                                      return 'password must be more than 6';
                                    }
                                    if (confirmPasswordController.text !=
                                        passwordController.text) {
                                      return 'Incorrect password';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: 'Repeat your password',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                )),
                            SizedBox(height: 10),
                            SizedBox(height: 30),
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.indigoAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    if (KEY.currentState!.validate()) {
                                      setState(() {
                                        changePassword(widget.email! , password!);
                                      });
                                    }
                                  },
                                  child: Text('Confirm')),
                            ),
                          ]),
                    )),
              )),
        ],
      )),
    );
  }

  @override
  void initState() {}
  Future<void> changePassword(String email2, String pass) async {
    final Map<String, dynamic> body = {'email': email2, 'newPassword': pass};
    final http.Response response = await http.post(
        Uri.parse('http://api.bluelightlms.com/changePassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }, body: jsonEncode(body)
    );
    Map<String, dynamic> map = jsonDecode(response.body);
    String message = map['message'];
    if (response.statusCode == 200) {
      if (message == 'Done') {
        Navigator.push(context,
            MaterialPageRoute(
              builder: (context) {
                return loginpage();
              },
            ));
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error')));
    }
  }

}
