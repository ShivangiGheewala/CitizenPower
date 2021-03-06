import 'package:citizenpower/views/profileViews/profile_list.dart';
import 'package:citizenpower/views/genericWidgets/generic_layouts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controllers/electorateControllers/leader_profile_controller.dart';
import '../../text_styles.dart';
import '../../constants.dart';
import 'package:url_launcher/url_launcher.dart';

/*TODO:
- Create a 'Clark' electorate profile
- Change Grace image to picture of 'Local Member: MP Andrew Wilkie'
- Change numbers to electorate statistics, e.g. population number etc
- Put in button to email/get in touch
 */

//Leader controller manages the downloading of leader data based on the selected
//electorate from previous view
LeaderController leaderController = LeaderController();

class Electorate extends StatefulWidget {
  const Electorate(
      {Key key,
      @required this.user,
      this.stateID,
      this.leaderUID,
      this.electorateID,
      this.upper})
      : super(key: key);
  //Stores the currently logged in user, passed in from the previous state
  final FirebaseUser user;
  //ID used to query Cloud Firestore
  final String stateID;
  //ID used to query FB for the electorate that the user has chosen
  final String electorateID;
  //ID passed in from previous view based on which leader the user selected
  //and used in FB download queries
  final String leaderUID;
  //Upper is used to know to query from state collection or electorate collection
  final bool upper;
  @override
  _ElectorateState createState() => _ElectorateState();
}

class _ElectorateState extends State<Electorate> {
  //Used to keep track of whether the leader's bio is expanded
  bool isExpanded = true;
  String issues;
  List<String> _locations = ['Poverty', 'Pollution', 'Homeless'];
  //Used to block bottom nav bar functions
  int currentIndex = 4;
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'khernyihjun@gmail.com',
      queryParameters: {'subject': 'ELECTNOW: Constituent Message'});
  @override
  Widget build(BuildContext context) {
    //Load the profile based on the selected electorate and leader from previous views.

    if (leaderController.leaderSnapshot == null ||
        widget.leaderUID != leaderController.leaderSnapshot.documentID) {
      if (widget.upper == false) {
        leaderController
            .loadLowerLeader(
                widget.stateID, widget.electorateID, widget.leaderUID)
            //Once leader profile has been loaded, rebuild widget
            .then((val) async {
          setState(() {});
        });
      } else {
        leaderController.loadUpperLeader(widget.stateID, widget.leaderUID)
            //Once leader profile has been loaded, rebuild widget
            .then((val) async {
          setState(() {});
        });
      }
    }

    //Has leaderSnapshot been downloaded? Run primary leader profile view
    return leaderController.leaderSnapshot != null
        ? Scaffold(
            appBar: topAppBarLayout('Leader'),
            drawer: new Drawer(
              child: new ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: new Text(leaderController.getName()),
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
                child: SizedBox(
                  height: 15,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FlatButton(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  NetworkImage(leaderController.getPicLink()),
                            ),
                          ),
                          onPressed: () {
                            //TODO:Edit function for current logged in user's profile picture
                          },
                        ),
                      ],
                    ),
                    //Needs to link to a profile list
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          leaderController.getName(),
                          style: profileNameStyle(),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        MaterialButton(
                          child: Text(
                            "Follow " +
                                getFirstWord(leaderController.getName()),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: darkGold,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileList(user: null)));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  height: 15,
                  color: Colors.black,
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
                    margin:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Bio:',
                        ),
                        Padding(padding: EdgeInsets.only(top: 0, bottom: 0)),
                        Text(
                          leaderController.getBio(),
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
                  margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Electorate",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(leaderController.getElectorate()),
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
                          Text(leaderController.getParty()),
                        ],
                      ),
                      Divider(
                        height: 10,
                        color: Colors.black,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "In Power",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(leaderController.getPower()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                //child:Container(
                child: RaisedButton(
                  onPressed: () async {
                    const url = "tel:+61450632382";
                    if (await canLaunch(url) == true) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  elevation: 0.0,
                  padding: EdgeInsets.all(.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [darkGold, brightOrange]),
                      //borderRadius: BorderRadius.circular(30.0),
                    ),
                    constraints: BoxConstraints(
                        maxWidth: double.infinity, minHeight: 40.0),
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.phone, color: Colors.white),
                          Text(
                            "+61 450 632 382",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w300),
                          )
                        ]),
                  ),
                ),
              ),
              //),
              SliverToBoxAdapter(
                  child: RaisedButton(
                onPressed: () {
                  launch(_emailLaunchUri.toString());
                },
                elevation: 0.0,
                padding: EdgeInsets.all(.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [darkGold, brightOrange]),
                    //borderRadius: BorderRadius.circular(30.0),
                  ),
                  constraints: BoxConstraints(
                      maxWidth: double.infinity, minHeight: 40.0),
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.mail, color: Colors.white),
                        Text(
                          "khernyihjun@gmail.com",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w300),
                        )
                      ]),
                ),
              )),
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
                      if (issues == "Poverty") {
                        Text("This has been a major issue for this company");
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
          )

        //leaderSnapshot not downloaded? Show loading indicator
        : Container(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
