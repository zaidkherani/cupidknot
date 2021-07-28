import 'package:flutter/material.dart';
import 'login2.dart';
import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Signup2 extends StatefulWidget {

  @override
  _Signup2State createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {

  bool checkedValue = false;
  String fname , lname , email , password , confirmpassword ,  gender ;
  var dob;
  List registerresponse = [];
  bool isloading = false;
  final String url = "https://cupidknot.kuldip.dev/api/register";

  register() async {
    setState(() {
      isloading = true;
    });
    var response = await http.post(Uri.parse(url),body:{
      "first_name":fname,
      "last_name":lname,
      "email": email,
      "password": password,
      "password_confirmation": confirmpassword,
      "birth_date": dob,
      "gender": gender
    });
    setState(() {
      var data = json.decode(response.body);
      registerresponse.add(data);
      isloading = false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', registerresponse[0]['access_token']);
    prefs.setString('refresh_token', registerresponse[0]['refresh_token']);
    print(prefs.get("register_token"));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    //height * 0.0122 = 10 height
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.redAccent.shade700,
        title: Center(
          child: Text("Login",
            style: TextStyle(
              fontSize: ((width * 0.025) * 2),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          :Container(
        height: height,
        width: width,
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              height: 80,
            ),

            Container(
              //margin: EdgeInsets.only(top: 50),
              height: height,
              width: width,
              color: Colors.white,
              child:  Padding(
                padding: EdgeInsets.only(left: ((width * 0.025) * 4),right: ((width * 0.025) * 4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(

                      padding:  EdgeInsets.only(left: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ((width * 0.025) * 0.4)),
                            child: Icon(Icons.mail,size: 30.0,color: Colors.blueGrey,),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: ((width * 0.025) * 1.5)),
                            child: Container(
                              width: ((width * 0.025) * 23),
                              height: (height * 0.0122) * 4.5,
                              child: Center(
                                child: TextField(
                                  onChanged: (value){
                                    setState(() {
                                      fname = value;
                                    });
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: ((width * 0.025) * 1.4),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                      ),
                                      hintText: ' First Name'
                                  ),
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:  EdgeInsets.only(left: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ((width * 0.025) * 0.4)),
                            child: Icon(Icons.mail,size: 30.0,color: Colors.blueGrey,),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: ((width * 0.025) * 1.5)),
                            child: Container(
                              width: ((width * 0.025) * 23),
                              height: (height * 0.0122) * 4.5,
                              child: Center(
                                child: TextField(
                                  onChanged: (value){
                                    setState(() {
                                      lname = value;
                                    });
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: ((width * 0.025) * 1.4),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                      ),
                                      hintText: ' Last Name'
                                  ),
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:  EdgeInsets.only(left: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ((width * 0.025) * 0.4)),
                            child: Icon(Icons.mail,size: 30.0,color: Colors.blueGrey,),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: ((width * 0.025) * 1.5)),
                            child: Container(
                              width: ((width * 0.025) * 23),
                              height: (height * 0.0122) * 4.5,
                              child: Center(
                                child: TextField(
                                  onChanged: (value){
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: ((width * 0.025) * 1.4),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                      ),
                                      hintText: ' Email'
                                  ),
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:  EdgeInsets.only(left: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ((width * 0.025) * 0.4)),
                            child: Icon(Icons.lock,size: ((width * 0.025) * 3),color: Colors.blueGrey,),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: ((width * 0.025) * 1.5)),
                            child: Container(
                              width: ((width * 0.025) * 23),
                              height: (height * 0.0122) * 4.5,
                              child: Center(
                                child: TextField(
                                  onChanged: (value){
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  autofocus: true,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: ((width * 0.025) * 1.4),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                      ),
                                      hintText: ' Password'
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:  EdgeInsets.only(left: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ((width * 0.025) * 0.4)),
                            child: Icon(Icons.lock,size: ((width * 0.025) * 3),color: Colors.blueGrey,),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: ((width * 0.025) * 1.5)),
                            child: Container(
                              width: ((width * 0.025) * 23),
                              height: (height * 0.0122) * 4.5,
                              child: Center(
                                child: TextField(
                                  onChanged: (value){
                                    setState(() {
                                      confirmpassword = value;
                                    });
                                  },
                                  autofocus: true,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: ((width * 0.025) * 1.4),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                      ),
                                      hintText: ' Confirm Password'
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),

                    DateTimePicker(

                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Select DOB',
                      style: TextStyle(
                        fontSize: ((width * 0.025) * 1.9),
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                      onChanged: (val) => dob = val,
                      // validator: (val) {
                      //   print(val);
                      //   return null;
                      // },
                     // onSaved: (val) => print(val),
                    ),
                    Divider(),
                    DropdownButton<String>(
                      value: gender,
                      elevation: 10,
                      style: TextStyle(color: Colors.black),
                      items: <String>[
                       "MALE",
                        "FEMALE"
                      ].map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                "$value",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: (width * 0.025) * 2,
                                ),
                              ),
                            );
                          }).toList(),
                      hint: Text(
                        " Select Gender",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: (width * 0.025) * 2.5,
                            fontWeight: FontWeight.w600),
                      ),
                      onChanged: (String value) {
                        setState(() {
                         gender = value;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: (height * 0.0122) * 5),
                      child: GestureDetector(
                        onTap: (){
                          register();
                          //print(fname + lname + email + password + confirmpassword +dob);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.redAccent.shade400,
                          ),
                          width: width,
                          height: (height * 0.0122) * 4.5,

                          child: Center(child: Text("SIGN IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ((width * 0.025) * 1.5),
                            ),
                          ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: (height * 0.0122) * 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login2()));
                            },
                            child: Text("Already Member? Login" ,
                              style: TextStyle(
                                fontSize: ((width * 0.025) * 1.6),
                                color: Colors.redAccent.shade400,
                                fontWeight: FontWeight.bold,
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

          ],
        ),
      ),
    );
  }
}

