import 'package:citizenpower/Navigator/NavigatorPushes.dart';
import 'package:citizenpower/Views/ElectorateViews/leaderslist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../Layouts/GenericLayouts.dart';
import '../../constants.dart';

import 'leader.dart';

/*TODO:
- Create a 'Clark' electorate profile
- Change Grace image to picture of 'Local Member: MP Andrew Wilkie'
- Change numbers to electorate statistics, e.g. population number etc
- Put in button to email/get in touch
 */

class Electorate extends StatefulWidget {
  const Electorate({Key key, @required this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  _ElectorateState createState() => _ElectorateState();
}

class _ElectorateState extends State<Electorate> {
  bool isExpanded = true;
  String issues;
  List<String> _locations = ['Issue 1', 'Issue 2', 'Issue 3'];
  //Used for bottom nav bar functions
  int currentIndex = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBarLayout('Leader'),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Andrew Wilkie"),
              accountEmail: new Text("andrewwilkie@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: darkGold,
                child: new Text(
                  "AW",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ),
            new ListTile(
              title: new Text("About me "),
              onTap: () => Navigator.of(context).pushNamed("/a"),
            ),
            new ListTile(
              title: new Text("Electorate details"),
              onTap: () => Navigator.of(context).pushNamed("/b"),
            )
          ],
        ),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: new Text(
            "Clark",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: coolGrey,
            ),
            textAlign: TextAlign.center,
          ),
        )),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 0),
            height: 75,
            child: Column(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(450),
                ),
                child: Image.asset(
                  "assets/Wilkie.jpeg",
                  height: 70,
                  width: 100,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ]),
          ),
        ),
        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Bio:',
                  ),
                  Padding(padding: EdgeInsets.only(top: 0, bottom: 0)),
                  Text(
                    'I am an Australian politician and independent federal member for Clark. Before entering politics i was an infantry officer in the Australian Army. I served with the Australian Army from 1980 to 2004',
                    overflow: TextOverflow.ellipsis,
                    maxLines: isExpanded ? null : 100,
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Current MP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Andrew Wilkie"),
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Party",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Independent"),
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "74K",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text("population"),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: RaisedButton(
            color: darkGold,
            textColor: Colors.white,
            child: Text('Leader'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LeadersList()));
            },
          ),
        ),
        SliverToBoxAdapter(
          child: DropdownButton(
            hint: Text(
              "Top issues",
              style: TextStyle(color: darkGold),
            ),
            value: issues,
            onChanged: (newValue) {
              // ignore: missing_return
              setState(() {
                issues = newValue;
                if (issues == "Issue 1") {
                  print(Text("This has been a major issue for this company"));
                  return Column(children: <Widget>[
                    Text(" This has been a major issue for this company")
                  ]);
                }
                if (issues == "Issue 2") {
                  return Column(children: <Widget>[Text("This")]);
                }

                if (issues == "Issue 3") {
                  return Column(children: <Widget>[Text("is")]);
                }
              });
            },
            items: _locations.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: bottomNavBarItems(),
          onTap: (index) {
            setState(() {
              onTap(index, context, widget.user, currentIndex);
            });
          }
          //onTap: _onTap,
          ),
    );
  }
}
