import 'package:citizenpower/databaseServices/database.dart';
import 'package:citizenpower/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class ProfileController {
  //Holds FS Snapshot once it is downloaded from FS
  DocumentSnapshot profileSnapshot;
  //Holds the current logged in user
  //The profile that will be loaded into profile View
  Profile profile = Profile();
  //Class containing methods for downloading from FS
  ProfileDatabaseMethods profileDatabaseMethods = ProfileDatabaseMethods();
  File profileImage;

  //get name of downloaded profile
  String getName() {
    return profile.name;
  }

  //get bio of downloaded profile
  String getBio() {
    return profile.bio;
  }

  //get pic URL of downloaded profile
  String getPic() {
    return profile.picLink;
  }

  //get full downloaded profile
  Profile getProfile() {
    return profile;
  }

  updateBio(String uID, String bio) {
    if (bio != null) {
      profileDatabaseMethods.updateUserBio(bio, uID);
    }
  }

  //uploads the given name to the document with the corresponding uID
  updateName(String uID, String name) {
    if (name != null) {
      profileDatabaseMethods.updateUserName(name, uID);
    }
  }

  uploadProfilePic(BuildContext context, String uID, bool changedPic) async {
    //Only runs the the function if the the user has actually updated their profile picture to prevent storage waste
    if (changedPic == true) {
      profileDatabaseMethods.uploadPic(context, profileImage).then((val) {
        profileDatabaseMethods.updatePicLink(val, uID);
      });
      //Arbitrarily wait so that updatePicLink can be completed so the new data is loaded in my_profile
      await Future.delayed(Duration(seconds: 3));
    }
    //Used to ensure that all profile data has been uploaded before moving back to my profile for download
  }

  //Takes the UID of a user and returns a Stream<QuerySnapshot> to build a list of post widgets
  //based on how many posts are present in the users post collection
  getUserPosts(String uID) async {
    return profileDatabaseMethods.getUserPostsByUID(uID);
  }

  //Used to get profile data, async to allow setState use in view
  loadProfile(String uID) async {
    profileDatabaseMethods
        //Downloads profile based on the UID stored in user from app login
        .getUserByUID(uID)
        //getUserByUID() returns a Future (main program thread continues),
        // 'then()' only runs once Future is actually downloaded and becomes a DocumentSnapshot
        //Once DocumentSnapshot is downloaded snapshot is stored in profileSnapshot and
        // widget is rebuilt in view using SetState()
        .then((val) {
      profileSnapshot = val;
      profile.name = profileSnapshot.data["name"];
      profile.bio = profileSnapshot.data["bio"];
      profile.picLink = profileSnapshot.data["picLink"];
    });
  }
}
