import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

class MyProfile extends StatefulWidget {

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List data = [];
  bool isloading = true;
  String fname  , lname , email ,  gender ,religion ;
  var dob;
  getmydata() async {

    String url2 = "https://cupidknot.kuldip.dev/api/user";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(url2),headers: {
      "Accept":"Application/json",
      "Authorization": "Bearer "+ prefs.getString("access_token")
    });

    var data = jsonDecode(response.body);

    setState(() {

      var name = data['name'].split(' ');
      fname = name[0];
      lname = name[1];
      email = data['email'];
      dob = data['birth_date'];
      gender = data['gender'];
      religion = data['religion'];
      isloading = false ;
    });
  }

  update() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url2 = "https://cupidknot.kuldip.dev/api/update_user";

    setState(() {
      isloading = true;
    });
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd H:m:s');
    String formattedDate = formatter.format(now);
    var response = await http.post(Uri.parse(url2),
        headers:{
          "Accept":"Application/json",
          "Authorization": "Bearer "+ prefs.getString("access_token")
        },
        body:{
      "first_name":fname,
      "last_name":lname,
      "email": email,
      "religion": religion,
      "birth_date": dob,
      "gender": gender,
      "updated_at":  formattedDate
    });
    setState(() {
      var res = json.decode(response.body);
      data = [];
      data.add(res["data"]);
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmydata();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
      ?Center(child: CircularProgressIndicator(),)
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
                                      hintText:fname
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
                                      hintText: lname
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
                                      hintText: email
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
                                      religion = value;
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
                                      hintText: religion
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
                      dateLabelText: "DOB "+dob,
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
                          update();
                          //print(fname + lname + email + password + confirmpassword +dob);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.redAccent.shade400,
                          ),
                          width: width,
                          height: (height * 0.0122) * 4.5,

                          child: Center(child: Text("Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ((width * 0.025) * 2),
                            ),
                          ),
                          ),
                        ),
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
