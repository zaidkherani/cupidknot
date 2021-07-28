import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myrandomusergenerator/login2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyProfile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List usersData;

  bool isloading = true;
  String name="" , email="" ;
  final String url = "https://cupidknot.kuldip.dev/api/users";

  Future getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(url),headers: {
      "Accept":"Application/json",
      "Authorization": "Bearer "+prefs.getString("access_token")

    });
    var res = jsonDecode(response.body);

    if(res['message'] == "Unauthenticated."){
      print(1);
      refresh_token();
    }else{
      print(2);
      var data = jsonDecode(response.body)['data'];

      setState(() {
        usersData = data['data'];
        isloading = false;
      });
    }
  }
  refresh_token() async {
    print(3);
    String url2 = "https://cupidknot.kuldip.dev/api/refresh";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(url2),body:{
      "refresh_token":prefs.getString("refresh_token"),
    });
    var data = jsonDecode(response.body);
    print(data);
    if(data['token_type'] == "Bearer"){
      print(4);
      prefs.clear();
      prefs.setString('access_token', data['access_token']);
      prefs.setString('refresh_token', data['refresh_token']);
      getData();
      getmydata();
    }else if(data['error'] == "invalid_request"){
      print(5);
      signout();
    }
  }

  getmydata() async {

    String url2 = "https://cupidknot.kuldip.dev/api/user";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(url2),headers: {
      "Accept":"Application/json",
      "Authorization": "Bearer "+ prefs.getString("access_token")
    });

    var data = jsonDecode(response.body);

    setState(() {

      name = data['name'];
      email = data['email'];
    });

  }
  signout() async {

    String url2 = "https://cupidknot.kuldip.dev/api/logout";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(url2),headers: {
      "Accept":"Application/json",
      "Authorization": "Bearer "+ prefs.getString("access_token")
    });

    var data = jsonDecode(response.body);
    print(6);
    print(data);
    if(data['message'] == "GoodBye!"){
      print(7);
      prefs.clear();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login2()));
    }else if(data['message'] == "Unauthenticated."){
      print(8);
      prefs.clear();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login2()));

    }

  }

  @override
  void initState() {
    super.initState();
    this.getData();
    this.getmydata();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
      ),
      drawer: new Drawer(
        elevation: 0.0,
        child: new ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
              accountName:
              this.name != null ? Text("${this.name}") : Text(""),
              accountEmail: Text("${this.email}"),


              decoration: new BoxDecoration(
                color: Colors.orange,
              ),
            ),
//            body
            SizedBox(
              height: (width * 0.025) * 2,
            ),


            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
              },
              child: ListTile(
                title: Text('My Profile',
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.redAccent[200],
                ),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {
                signout();
              },
              child: ListTile(
                title: Text('Log out',
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
                leading: Icon(
                  Icons.transit_enterexit,
                  color: Colors.redAccent[200],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: isloading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: usersData == null ? 0 : usersData.length,
                  itemBuilder: (BuildContext context, int index) {
                    List image = usersData[index]["user_images"];
                    var imagename = "";
                    image.length > 0
                        ? imagename = image[0]['path'] + image[0]['name']
                        : imagename = "http://joinwhitelist.com/profile_images/download.jpg";
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20.0),
                                width: 70.0,
                                height: 70.0,
                                //fit: BoxFit.contain,
                                child: Image.network(imagename)

                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  usersData[index]["name"],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.mail),
                                    Text(usersData[index]['email']),
                                  ],
                                ),
                                Text("Gender: ${usersData[index]['gender']}"),
                                Text("DOB: ${usersData[index]['birth_date']}"),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
