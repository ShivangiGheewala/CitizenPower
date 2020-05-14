import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() => runApp(new MyApp());

const Map<int, Color> color = {
  //Provides transparency parameter for all material colours
  50: Color.fromRGBO(216, 96, 24,
      .1), //RGB values are irrelevant, only transparency (4th) parameter is relevant
  100: Color.fromRGBO(216, 96, 24, .2),
  200: Color.fromRGBO(216, 96, 24, .3),
  300: Color.fromRGBO(216, 96, 24, .4),
  400: Color.fromRGBO(216, 96, 24, .5),
  500: Color.fromRGBO(216, 96, 24, .6),
  600: Color.fromRGBO(216, 96, 24, .7),
  700: Color.fromRGBO(216, 96, 24, .8),
  800: Color.fromRGBO(216, 96, 24, .9),
  900: Color.fromRGBO(216, 96, 24, 1),
};

const MaterialColor brightOrange =
    MaterialColor(0xFFD86018, color); //All style guide colours implemented
const MaterialColor coolGrey =
    MaterialColor(0xFF53565A, color); //Any more colours needed to be added here
const MaterialColor alloyOrange = MaterialColor(0xFFB86125, color);
const MaterialColor darkGold = MaterialColor(0xFFC69214, color);
const MaterialColor ashGrey = MaterialColor(0xFFBABBB1, color);
const MaterialColor moshGreen = MaterialColor(0xFF9B945F, color);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new LoginPage(),
        theme: new ThemeData(primaryColor: brightOrange));
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: brightOrange,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      backgroundColor: coolGrey,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Form(
            key: _formKey,
            child: new Theme(
              data: new ThemeData(
                brightness: Brightness.dark,
              ),
              child: new Container(
                padding: const EdgeInsets.all(5.0),
                height: 160,
                width: 100,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new TextFormField(
                      decoration: new InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0,
                          ),
                          labelText: "Email",
                          hintText: "Enter Email address"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "please Insert a valid Email address";
                        }
                        return null;
                      },
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15,
                        ),
                        labelText: "Password",
                        hintText: " Enter Password",
                      ),
                      keyboardType: TextInputType.text,
                      validator: (val) => val.length < 6
                          ? 'Insert Password/Incorrect Password'
                          : null,
                      obscureText: true,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20),
                    ),
                    new MaterialButton(
                        color: Colors.green,
                        textColor: Colors.black87,
                        child: new Text("LOGIN"),
                        onPressed: () {
                          if (_formKey.currentState.validate())
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()),
                            );
                        }),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new MaterialButton(
                        color: Colors.indigo,
                        textColor: Colors.tealAccent,
                        minWidth: 50,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        child: new Text("SIGN UP/REGISTER"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a Snackbar.
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()),
                          );
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /*_onTap(int index) {
      //functions to determine which page to display base on which icon is pressed
      //on the navigation bar,
      //the code below doesn't work, so it is commented out-Yih Jun
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Electorate()),
      );
    }
*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          " Profile ",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            height: 300,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/grace.jpg",
                    height: 230,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Grace Williams"),
                new Text("Lives at Hobart , Tasmania"),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "04",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Posts"),
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "213",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Connections"),
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "1K",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Linked To"),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              Divider(
                height: 10,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(left: 100, right: 100, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => {},
                      color: Colors.orange,
                      padding: EdgeInsets.only(left: 2, right: 2, top: 10),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.person_pin_circle),
                          Text("Electorate")
                        ],
                      ),
                    ),

                    //Below code removed and replaced with flat button for electorate
                    /*
                    Icon(Icons.grid_on),
                    //Icon(Icons.list),
                    Icon(Icons.person_pin_circle),
                    */
                  //Below code removed and replaced with flat button for electorate

                    Icon(Icons.grid_on),
                    //Icon(Icons.list),
                    Icon(Icons.person_pin_circle),
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: Colors.black,
              ),
            ],
          ),
        ),
        SliverStaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            staggeredTiles: [
              StaggeredTile.count(1, 2),
              StaggeredTile.count(1, 1),
              StaggeredTile.count(1, 1),
            ],
            children: <Widget>[
              ClipRect(
                child: Image.asset("assets/img.png", fit: BoxFit.cover),
              ),
              ClipRect(
                child: Image.asset("assets/img.png", fit: BoxFit.cover),
              ),
              ClipRect(
                child: Image.asset("assets/img.png", fit: BoxFit.cover),
              ),
            ])
      ]),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_circle),
            title: Text('Electorate'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('Event'),
          ),


          /*OLD NAV BAR CODE
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Dashboard'),
            //backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Group'),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Add'),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('Event'),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            backgroundColor: Colors.black,
          ),

           */
        ],
        //function for when user taps an icon on navigation bar-Yih Jun
        //onTap: _onTap,
      ),
    );
  }
}

//Starting Electorate page which needs to be linked to the NavBar
class Electorate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          " Electorate ",
          style:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(Icons.more_vert),
          ),
        ],
      )
    );
  }
}

//hello
class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Register ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: new Stack(
        children: <Widget>[
          new Form(
            child: new Theme(
              data: new ThemeData(
                brightness: Brightness.dark,
              ),
              child: new Container(
                padding: const EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Name ",
                          hintText: "Enter Your Full name "),
                      keyboardType: TextInputType.text,
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Email/phone",
                          hintText: "Enter Email address"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "please insert valid email";
                        }
                        return null;
                      },
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Enter Password",
                        hintText: " Password",
                      ),
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val.length < 6 ? 'Please Insert password' : null,
                      obscureText: true,
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10.0)),
                    Flex(direction: Axis.horizontal),
                    new MaterialButton(
                        color: Colors.tealAccent,
                        textColor: Colors.black,
                        child: new Text("SUBMIT"),
                        onPressed: () {})
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
