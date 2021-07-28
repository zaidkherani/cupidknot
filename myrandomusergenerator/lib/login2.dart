import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Signup2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login2 extends StatefulWidget {

  @override
  _Login2State createState() => _Login2State();
}

class _Login2State extends State<Login2> {

  final _formKey = GlobalKey<FormState>();
  String username , password ;
  List loginresponse = [];
  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkauth();
  }
  checkauth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString("access_token") != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
    setState(() {
      isloading = false;
    });

  }

  final String url = "https://cupidknot.kuldip.dev/api/login";

    getData() async {
    var response = await http.post(Uri.parse(url),body:{
      "username":username,
      "password":password});
    setState(() {
      var data = jsonDecode(response.body);
      loginresponse.add(data);
      isloading = false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString('access_token', loginresponse[0]['access_token']);
    prefs.setString('refresh_token', loginresponse[0]['refresh_token']);
    print(prefs.getString("access_token"));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
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
          ? Center(child: CircularProgressIndicator(),)
          :Container(
        height: height,
        width: width,
        child: ListView(
          children: [
            Container(
              height: height/4,
              width: width,
              color: Colors.white,
            ),
            Container(
              height: (height * 0.0122) * 24.652,
              width: width,
              color: Colors.white,
              child:  Padding(
                padding: EdgeInsets.only(left: ((width * 0.025) * 4),right: ((width * 0.025) * 4)),
                child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: ((width * 0.025) * 0.4)),
                          child: Icon(Icons.mail,size: ((width * 0.025) * 3),color: Colors.blueGrey,),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: ((width * 0.025) * 1.5)),
                          child: Container(
                            width: ((width * 0.025) * 23),
                            height: (height * 0.0122) * 4.5,
                            child: Center(
                              child: TextField(
                                autofocus: true,
                                onChanged: (value){
                                  setState(() {
                                    username = value;
                                  });
                                },
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
                                    hintText: ' Username'
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
                                autofocus: true,
                                onChanged: (value){
                                  setState(() {
                                    password = value;
                                  });
                                },
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
                Padding(
                  padding: EdgeInsets.only(top: (height * 0.0122) * 5),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        isloading = true;

                      });
                      getData();
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
                   padding: EdgeInsets.only(top: (height * 0.0122) * 2),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       GestureDetector(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup2()));
                          },
                         child: Text("NEW HERE? SIGN UP" ,
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
