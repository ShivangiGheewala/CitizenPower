//import 'package:citizenpower/Views/ElectorateViews/leaders_profile_view.dart';
import 'package:citizenpower/views/electorateViews/image_view.dart';
import 'package:citizenpower/views/homeViews/homeDashboardView/app_home.dart';
import 'package:citizenpower/views/homeViews/settingsView/settings.dart';
import 'package:citizenpower/views/createNewPostView/create_post_view.dart';
import 'package:citizenpower/views/profileViews/my_profile.dart';
import 'package:citizenpower/views/profileViews/other_profile.dart';
import 'package:citizenpower/views/profileViews/profile_page_edit.dart';
import 'package:citizenpower/models/profile.dart';
import 'package:citizenpower/views/electorateViews/electorate.dart';
import 'package:citizenpower/views/profileViews/Profile.dart';
import 'package:citizenpower/views/profileViews/profile_list.dart';
import 'package:citizenpower/views/profileViews/search_profile.dart';
import 'package:citizenpower/views/socialViews/eventView/create_new_event.dart';
import 'package:citizenpower/views/socialViews/eventView/event_view.dart';
import 'package:citizenpower/views/socialViews/groupView/create_new_group.dart';
import 'package:citizenpower/views/socialViews/groupView/group_page.dart';
import 'package:citizenpower/views/socialViews/groupView/group_view.dart';
import 'package:citizenpower/views/socialViews/messageViews/home_screen.dart';
import 'package:citizenpower/views/socialViews/socialMenuView/social_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:citizenpower/views/electorateViews/electorate_selector_view.dart';
import '../views/postViews/commentViews/new_comments_page.dart';
import '../views/electorateViews/leaders_profile_view.dart';

//pushReplacement used for views accessed from bottom nav bar

goHome(BuildContext context, FirebaseUser user) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AppHome(user: user),
      ));
}

goOtherProfile(BuildContext context, FirebaseUser user, String, selectedUserID) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => OtherProfileScreen(user: user, selectedUserID: selectedUserID,)),
  );
}

goNewPost(BuildContext context, FirebaseUser user) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewPost(user: user),
      ));
}

goProfileView(BuildContext context, FirebaseUser user, String uID) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ProfileView(
              user: user,
              selectedProfileUID: uID,
            )),
  );
}

goElectorate(BuildContext context, FirebaseUser user, String stateID,
    String electorateUID, String leaderUID, bool upper) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => Electorate(
            user: user,
            stateID: stateID,
            electorateID: electorateUID,
            leaderUID: leaderUID,
            upper: upper)),
  );
}

goSelectedElectorate(BuildContext context, FirebaseUser user, String userState,
    String userElectorate) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ElectorateView(
              user: user,
              stateSelected: userState,
              electorateSelected: userElectorate,
            )),
  );
}

goSettings(BuildContext context, FirebaseUser user) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Setting(user: user)),
  );
}

goContactDetails(BuildContext context, FirebaseUser user) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AppHome(user: user)),
  );
}

goProfileList(BuildContext context, FirebaseUser user) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProfileList(user: null)));
}

goMyProfilePage(BuildContext context, FirebaseUser user) {
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => MyProfilePage(user: user)));
}

goSocialMenu(BuildContext context, FirebaseUser user) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => SocialMenu(user: user)));
}

goMessage(BuildContext context, FirebaseUser user) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
}

goEvent(BuildContext context, FirebaseUser user) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => EventView(user: user)));
}

createEvent(BuildContext context, FirebaseUser user) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => CreateNewEvent(user: user)));
}

goElectorateView(BuildContext context, FirebaseUser user) {
  Navigator.push(
      context,

      //** CHANGED FOR NEW ELECTORATE SELECTOR PAGE - OLD CODE COMMENTED OUT BELOW **

      MaterialPageRoute(
          builder: (context) => ElectorateSelectorView(user: user)));
  //MaterialPageRoute(builder: (context) => ElectorateView(user: user)));
}

goSearch(BuildContext context, FirebaseUser user) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SearchView(user: user)));
}

goComment(BuildContext context, FirebaseUser user) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CommentScreen()));
}

goImageView(BuildContext context, String image) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ImageView(image: image)),
  );
}

goEditProfile(BuildContext context, FirebaseUser user, Profile myProfile) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => ProfilePageEdit(
              user: user,
              profile: myProfile,
            )),
  );
}

goCreateGroup(BuildContext context, FirebaseUser user) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => CreateNewGroup(user: user)));
}

goGroupList(BuildContext context, FirebaseUser user) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => GroupView(user: user)));
}

goGroupView(BuildContext context, FirebaseUser user, String groupID,
    QuerySnapshot groupSnapshot, int index) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GroupPage(
              user: user,
              groupID: groupID,
              groupSnapshot: groupSnapshot,
              index: index)));
}
