import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/main.dart';
import 'package:events_app/screens/create_society.dart';
import 'package:events_app/screens/profilePage.dart';
import 'package:events_app/screens/viewUserSocieties.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/eventFeed_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  final ApiUserSignUpModel user;
  bool isfeed = false;

  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Beckend apicall = new Beckend();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apicall.getallevents(token: widget.user.token),
        builder:
            (BuildContext context, AsyncSnapshot<List<ApiEventModel>> result) {
          return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.replay_outlined))
                ],
                elevation: 0,
                title: CustomText(
                  text: "Events",
                  letterspacing: 5,
                  fontWeight: FontWeight.bold,
                  size: 20,
                ),
                centerTitle: true,
              ),
              drawer: Drawer(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      accountEmail: CustomText(
                        text: widget.user.email,
                        color: Colors.black,
                        size: 16,
                      ),
                      accountName: CustomText(
                          text:
                              // userVarified
                              //     ? userProvider.varifiedUser.name
                              //   :
                              "",
                          color: Colors.black,
                          size: 20),
                    ),
                    widget.user.isvarified
                        ? ListTile(
                            title: Text(
                              "Create Society",
                              style: TextStyle(fontSize: 20),
                            ),
                            leading: Icon(
                              Icons.food_bank_outlined,
                              size: 35,
                            ),
                            onTap: () => {
                              Navigator.pop(context),
                              changeScreen(
                                  context,
                                  CreateSociety(
                                    userModel: widget.user,
                                  ))
                            },
                          )
                        : Divider(
                            thickness: 0,
                          ),
                    widget.user.isvarified
                        ? ListTile(
                            title: Text(
                              "My Socities",
                              style: TextStyle(fontSize: 20),
                            ),
                            leading: Icon(
                              Icons.shopping_cart,
                              size: 35,
                            ),
                            onTap: () async {
                              List<ApiSocietyModel> adminSocities =
                                  await apicall.getAdminSocieties(
                                      email: widget.user.email,
                                      token: widget.user.token);

                              changeScreen(
                                  context,
                                  ViewMemberSocieties(
                                    memberSocieties: adminSocities,
                                    user: widget.user,
                                  ));
                            },
                          )
                        : ListTile(
                            title: Text(
                              "Varify Yourself",
                              style: TextStyle(fontSize: 20),
                            ),
                            leading: Icon(
                              Icons.bookmark_border,
                              size: 35,
                            ),
                            onTap: () => {
                              print(widget.user.token),
                              changeScreen(
                                  context,
                                  ProfilePage(
                                    user: widget.user,
                                  ))
                            },
                          ),
                    ListTile(
                      title: Text(
                        "Settings",
                        style: TextStyle(fontSize: 20),
                      ),
                      leading: Icon(
                        Icons.settings,
                        size: 35,
                      ),
                      onTap: () => {},
                    ),
                    ListTile(
                      onTap: () {
                        //context.read<AuthenticationService>().signOut();

                        changeScreenReplacement(context, MyApp());
                      },
                      leading: Icon(
                        Icons.exit_to_app,
                        size: 35,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              body: SafeArea(
                  child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: CustomText(
                  //     text: "Events",
                  //     size: 20,
                  //     fontWeight: FontWeight.bold,
                  //     letterspacing: 5,
                  //   ),
                  // ),
                  Divider(),
                  Expanded(
                    child: ListView(
                      children: apicall.events
                          .map((e) => GestureDetector(
                                onTap: () {},
                                child: EventFeed(
                                  showhostsoc: true,
                                  event: e,
                                  user: widget.user,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              )));
        });
  }
}
