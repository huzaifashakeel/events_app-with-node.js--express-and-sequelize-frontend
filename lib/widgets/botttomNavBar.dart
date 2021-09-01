import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/screens/explorePage.dart';
import 'package:events_app/screens/homePage.dart';
import 'package:events_app/screens/showUserProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavBar extends StatefulWidget {
  final ApiUserSignUpModel user;

  const BottomNavBar({Key? key, required this.user}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  Beckend apicall = Beckend();
  ApiUserModel user = ApiUserModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apicall.loadEventhost(
            hostemail: widget.user.email, token: widget.user.token),
        builder: (BuildContext context, AsyncSnapshot<ApiUserModel> result) {
          return SafeArea(
              child: PersistentTabView(
            context,
            controller: _controller,
            screens: [
              HomePage(
                user: widget.user,
              ),
              ExplorePage(
                user: widget.user,
              ),
              Container(),
              Container(),
              ShowUserProfile(
                  userModel: result.data, userSignUpModel: widget.user),
            ],
            items: [
              PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.home),
                title: ("Home"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
              ),
              PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.search),
                title: ("Explore"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
              ),
              PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.bell),
                title: ("Notifications"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
              ),
              PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2),
                title: ("Chat"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
              ),
              PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                title: ("Profile"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
              ),
            ],
            confineInSafeArea: true,
            backgroundColor: Colors.black54, // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset:
                true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: false, // Default is true.
            hideNavigationBarWhenKeyboardShows:
                true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 300),
            ),
            navBarStyle: NavBarStyle
                .style11, // Choose the nav bar style with this property.
          ));
        });
  }
}
