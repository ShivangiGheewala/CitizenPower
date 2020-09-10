import 'package:citizenpower/constants.dart';
import 'package:citizenpower/controllers/post_controller.dart';
import 'package:citizenpower/layouts/generic_layouts.dart';
import 'package:citizenpower/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

PostController postController = PostController();

class NewPost extends StatefulWidget {
  final FirebaseUser user;
  const NewPost({Key key, this.user}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final postTextController = TextEditingController();

  int currentIndex = 2;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //Stores the file in the profile controller
    //And reruns state build to show the selected picture
    setState(() {
      postController.postImage = image;
    });
  }

  //_openCamera() {}

  _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: Text("Please select one"), actions: [
            Container(
              padding: EdgeInsets.only(right: 20),
              child: FlatButton(
                child: Text(
                  "Camera",
                  style: TextStyle(fontSize: 30.0),
                ),
                onPressed: () {
                  getImage();
                },
              ),
            ),
            FlatButton(
              child: Text(
                "Gallery",
                style: TextStyle(fontSize: 30.0),
              ),
              onPressed: () {
                getImage();
              },
            )
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final maxLines = 12;
    return Scaffold(
      appBar: new AppBar(
        title: Text("Create New Post"),
        elevation: 1.0,
        actions: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.white30,
              child: IconButton(
                onPressed: () {
                  postController.uploadPost(
                      context, postTextController.text, widget.user.uid);
                },
                icon: Icon(
                  Icons.send,
                  size: 22,
                  color: Color.fromRGBO(195, 195, 195, 1),
                ),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8),
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/Wilkie.jpeg"),
                  ),
                ],
              ),
              TextField(
                maxLines: maxLines,
                minLines: 5,
                decoration:
                    InputDecoration(hintText: "whats on your mind today?"),
                controller: postTextController,
              ),
              postController.postImage != null
                  ? Container(
                      padding: EdgeInsets.only(top: 5.0),
                      height: 200,
                      child: Image.file(postController.postImage))
                  //Simplest way to do if statements apparently
                  : Container(
                      height: 0,
                    ),
              const Divider(
                height: 10.0,
                thickness: 0.5,
              ),
              Row(
                children: <Widget>[
                  FlatButton.icon(
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      icon: const Icon(
                        Icons.photo,
                        color: Colors.orangeAccent,
                      ),
                      label: Text("Photo")),
                  const VerticalDivider(
                    width: 7,
                  ),
                  FlatButton.icon(
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      icon: const Icon(
                        Icons.videocam,
                        color: Colors.redAccent,
                      ),
                      label: Text("Videos")),
                  const VerticalDivider(
                    width: 7,
                  ),
                  FlatButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.location_on,
                        color: darkGold,
                      ),
                      label: Text("Location")),
                ],
              ),
            ],
          ),
        ),
        color: Colors.grey[100],
      ),
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
