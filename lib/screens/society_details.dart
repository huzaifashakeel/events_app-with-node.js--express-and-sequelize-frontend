import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/screens/create_event.dart';
import 'package:events_app/screens/homePage.dart';
import 'package:events_app/screens/viewsocietyMembers.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/eventFeed_widget.dart';
import 'package:events_app/widgets/society_info.dart';
import 'package:flutter/material.dart';

class SocietyDetails extends StatefulWidget {
  final bool isadmin;
  final ApiSocietyModel society;
  final ApiUserSignUpModel user;
  final List<ApiUserModel> societyFollowers;
  final List<ApiEventModel> societyEvents;

  const SocietyDetails(
      {Key? key,
      required this.society,
      required this.user,
      required this.isadmin,
      required this.societyFollowers,
      required this.societyEvents})
      : super(key: key);

  @override
  _SocietyDetailsState createState() => _SocietyDetailsState();
}

class _SocietyDetailsState extends State<SocietyDetails> {
  bool showSocietyEvents = false;
  @override
  Widget build(BuildContext context) {
    print(widget.societyFollowers);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Beckend apicall = Beckend();
    bool ifalreadyliked = false;
    // ignore: unused_local_variable
    int showinsublist;
    int memberscount = apicall.societyfollowers.length;
    if (memberscount > 6)
      showinsublist = 6;
    else
      showinsublist = memberscount;

    print(apicall.societyfollowers);

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: apicall.addorchecksocietyMember(
                useremail: widget.user.email,
                socid: widget.society.id,
                token: widget.user.token,
                check: true),
            builder: (BuildContext context, AsyncSnapshot<bool> result) {
              if (result.data.toString() == "true") {
                ifalreadyliked = true;
              } else
                ifalreadyliked = false;
              return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: height * 0.3,
                            width: width,
                            child: Card(
                              elevation: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image(
                                  image: AssetImage("images/8.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                width * 0.35, height * 0.23, 0, 0),
                            child: CircleAvatar(
                              child:
                                  ClipOval(child: Image.asset("images/13.jpg")
                                      // FadeInImage.memoryNetwork(
                                      //   placeholder: kTransparentImage,
                                      //   image: widget.society.profileimage,
                                      //   fit: BoxFit.fill,
                                      //   height: height * 0.14,
                                      //   //width: 100,
                                      // ),
                                      ),
                              radius: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            //  child: Card(
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            //     ),
                          ),
                          if (widget.isadmin)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: DropdownButton<String>(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  elevation: 0,
                                  onChanged: (value) async {
                                    if (value == "Edit Event Society") {
                                    } else {
                                      int res = await apicall.deleteSociety(
                                          socid: widget.society.id,
                                          token: widget.user.token);
                                      if (res == 200) {
                                        changeScreenReplacement(context,
                                            HomePage(user: widget.user));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'A problem Occured while deleting Society')));
                                      }
                                    }
                                  },
                                  items: <String>[
                                    "Edit Society Details",
                                    "Delete Society"
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                                ),
                              ),
                            )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: CustomText(
                          text: widget.society.name,
                          fontWeight: FontWeight.w700,
                          size: 22,
                        ),
                      ),
                      widget.isadmin
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: height * 0.07,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return Colors.blue;
                                        },
                                      ),
                                    ),
                                    onPressed: () async {
                                      changeScreen(
                                          context,
                                          CreateEvent(
                                            eventorganizer: widget.society,
                                            token: widget.user.token,
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.17)),
                                        Icon(Icons.event),
                                        CustomText(
                                            text: "  Create An Event",
                                            size: 18,
                                            color: Colors.white),
                                      ],
                                    )),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: height * 0.07,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (ifalreadyliked)
                                            return Colors.grey;
                                          else
                                            return Colors.blue;
                                        },
                                      ),
                                    ),
                                    onPressed: () async {
                                      print(widget.society.id);
                                      await apicall.addorchecksocietyMember(
                                          socid: widget.society.id,
                                          token: widget.user.token,
                                          useremail: widget.user.email,
                                          check: false);
                                      setState(() {});
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.23)),
                                        Icon(Icons.group),
                                        CustomText(
                                            text: ifalreadyliked
                                                ? "  Unfollow"
                                                : "  Follow",
                                            size: 18,
                                            color: Colors.white),
                                      ],
                                    )),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.04, bottom: height * 0.02),
                        child: GestureDetector(
                          onTap: () {
                            changeScreen(
                                context,
                                ViewSocietyMembers(
                                  societyfollowers: widget.societyFollowers,
                                ));
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Row(
                                    children: widget.societyFollowers
                                        .map((item) => GestureDetector(
                                              onTap: () {
                                                changeScreen(
                                                    context,
                                                    ViewSocietyMembers(
                                                      societyfollowers: widget
                                                          .societyFollowers,
                                                    ));
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey.shade100,
                                                child: ClipOval(
                                                    child: Image.asset(
                                                        'images/7.jpg')
                                                    // FadeInImage.memoryNetwork(
                                                    //     fit: BoxFit.cover,
                                                    //     height: 60,
                                                    //     // width: 60,
                                                    //     placeholder:
                                                    //         kTransparentImage,
                                                    //     image: item
                                                    //         .profileimage),
                                                    ),
                                                radius: 20,
                                              ),
                                            ))
                                        .toList()
                                    // .sublist(0, showinsublist),
                                    ),
                                if (memberscount > 6)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                      text: "+" +
                                          (memberscount - 6).toString() +
                                          " Others",
                                      size: 16,
                                      color: Colors.black54,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(thickness: 2),
                      SocietyInfo(
                        society: widget.society,
                      ),
                      Divider(thickness: 2),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: widget.societyEvents
                            .map((item) => GestureDetector(
                                  onTap: () {},
                                  child: EventFeed(
                                    event: item,
                                    user: widget.user,
                                    showhostsoc: false,
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ));
            }),
      ),
    ));
  }
}
