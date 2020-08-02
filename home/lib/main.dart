import 'package:flutter/material.dart';
import 'AppHome.dart';
import 'Views/ElectorateViews/contactview.dart';
import 'Views/ElectorateViews/electorateprofiledetails.dart';
import 'loginpage.dart';
import 'constants.dart';

//Testing Github: I will be creating the electorate branch in this branch blah blah

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  int testNumber = 1;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new LoginPage(),
        routes: <String, WidgetBuilder>{
          "/a": (BuildContext context) => new AboutMe(),
          "/b": (BuildContext context) => new ElectorateDetails(),
          "/c": (BuildContext context) => new AppHome(),
          "/x": (BuildContext context) => new AppHome(user: null),
        },
        theme: new ThemeData(
            primaryColor: brightOrange, accentColor: Color(0xFFFEF9EB)));
  }
}
