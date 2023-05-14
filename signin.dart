import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'singup.dart';
import 'HomePgae.dart';
import 'check_Mail.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: loginpage(),
  ));
}

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  NewHome? newhome;
  List<NewHome> list = [];
  String? message;

  var email;
  var password;
  var response;
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
                            Text(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                'Welcome Back!'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    style: TextStyle(color: Colors.grey),
                                    "Don't have an account?"),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return signup();
                                    }));
                                  },
                                  child: Text(
                                      style:
                                          TextStyle(color: Colors.indigoAccent),
                                      'Register'),
                                )
                              ],
                            ),
                            SizedBox(height: 50),
                            Padding(
                              padding: EdgeInsets.only(right: 230, bottom: 8),
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                  'Your e-mail'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 50, left: 50),
                              child: TextFormField(onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                                keyboardType: TextInputType.emailAddress,validator: (email) => email != null &&
                                    !EmailValidator.validate(email)
                                    ? 'Invalid Mail'
                                    : null,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(Icons.mail)),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(right: 230, bottom: 8),
                              child: Text(
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                  'Password'),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 50, left: 50),
                                child: TextFormField(onChanged:  (value) {
                            setState(() {
                            password = value;
                            });
                            },
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
                            SizedBox(height: 10),
                            Padding(
                                child: GestureDetector(
                                    child: Text(
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                        'Forgot password?'),
                                    onTap: () { Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return check();
                                          },
                                        ));}),
                                padding: EdgeInsets.only(left: 190)),
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
                                  onPressed: () {if(KEY.currentState!.validate()){setState(() { postData(email, password);

                                  });

                                  }



                                  },
                                  child: Text('Sign In')),
                            ),
                          ]),
                    )),
              )),
        ],
      )),
    );

  }
  @override
  void initState() {


  }




  Future<void> postData(String email2, String password2) async {
    final Map<String, dynamic> loginData = {
      'email': email2,
      'password': password2,
    };

    final http.Response response = await http.post(
      Uri.parse('http://api.bluelightlms.com/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginData),
    );

    Map<String, dynamic> map = json.decode(response.body);
    print(response.body);
    String? message = map['message'];
     String token = map['token'] ?? '';
   if(response.statusCode == 200){
     if(message != null && message == 'Done'){
       SharedPreferences prefs = await SharedPreferences.getInstance();
       await prefs.setString('token', token);
       print(message);



       Navigator.push(context,
           MaterialPageRoute(
             builder: (context) {
               return homepage();
             },
           ));


     }
     else{

       print('-----------------------------------------');
       print('wrong');
       print('--------------------------------------------');
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text('Wrong email or Password')));
     }
   }
   else{

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Status code Not 200')));
   }



  }

}

class NewHome {
  NewHome.fromjson(Map<String, dynamic> movies) {}
}
get() async {
  http.Response response = await http.get(Uri.parse(
      'http://api.bluelightlms.com/profile?1'));
  Map<String, dynamic> map = json.decode(response.body);
  String message= map['wrong'];

}
