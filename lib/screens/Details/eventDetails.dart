import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/screens/Details/showUserProfile.dart';
import 'package:events_app/screens/Edit/editEventDetails.dart';
import 'package:events_app/screens/ViewCardsPages/vieweventfollwers.dart';
import 'package:events_app/screens/mainPages/homePage.dart';
import 'package:events_app/screens/mainPages/loading.dart';
import 'package:events_app/widgets/Eventrelated/eventSummaryCard.dart';
import 'package:events_app/widgets/SocietyRelated/society_infoCard.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:events_app/widgets/member_infoCard.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  final ApiEventModel event;
  final ApiUserSignUpModel user;
  final ApiUserModel eventhost;
  final List<ApiUserModel> eventfollowers;
  final ApiSocietyModel hostSociety;
  final bool showhostsoc;
  final bool isadmin;

  const EventDetails({
    Key? key,
    required this.event,
    required this.user,
    required this.showhostsoc,
    required this.eventhost,
    required this.hostSociety,
    required this.eventfollowers,
    required this.isadmin,
  }) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Beckend apicall = Beckend();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool ifalreadyliked = false;

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: FutureBuilder(
                    future: apicall.addorcheckEventMember(
                        useremail: widget.user.email,
                        eventid: widget.event.eventid,
                        token: widget.user.token,
                        check: true),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> result) {
                      if (result.data.toString() == "true") {
                        ifalreadyliked = true;
                      } else
                        ifalreadyliked = false;
                      return Column(children: [
                        Stack(
                          children: [
                            Container(
                              height: height * 0.35,
                              width: width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  child: Stack(
                                    children: [
                                      Loading(),
                                      Image.asset(
                                        "images/1.jpg",
                                        fit: BoxFit.cover,
                                        height: height * 0.35,
                                      )
                                      // FadeInImage.memoryNetwork(
                                      //   placeholder: kTransparentImage,
                                      //   image: widget.event.image,
                                      //   fit: BoxFit.fill,
                                      //   height: height * 0.35,
                                      //   width: width,
                                      // ),
                                    ],
                                  )),
                            ),
                            widget.isadmin
                                ? Padding(
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
                                          if (value == "Edit Event Details") {
                                            changeScreen(
                                                context,
                                                EditEvent(
                                                    event: widget.event,
                                                    token: widget.user.token));
                                          } else {
                                            int res = await apicall.deleteEvent(
                                                eventid: widget.event.eventid,
                                                token: widget.user.token);
                                            if (res == 200) {
                                              changeScreenReplacement(context,
                                                  HomePage(user: widget.user));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'A problem Occured while deleting Event')));
                                            }
                                          }
                                        },
                                        items: <String>[
                                          "Edit Event Details",
                                          "Delete Event"
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                              value: value, child: Text(value));
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Card(
                                        elevation: 2,
                                        color: Colors.white,
                                        child: Container(
                                          height: height * 0.07,
                                          width: width * 0.15,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.thumb_up,
                                              color: ifalreadyliked
                                                  ? Colors.blue
                                                  : Colors.black,
                                            ),
                                            onPressed: () async {
                                              await apicall
                                                  .addorcheckEventMember(
                                                      eventid:
                                                          widget.event.eventid,
                                                      useremail:
                                                          widget.user.email,
                                                      token: widget.user.token,
                                                      check: false);

                                              setState(() {});
                                              // }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.28, 0, 0),
                              child: EventSummaryCard(
                                event: widget.event,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: CustomText(
                                text: "About",
                                fontWeight: FontWeight.bold,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  width * 0.05, 0, 0, height * 0.01),
                              child: CustomText(
                                text:
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. When an unknown printer took a galley of type and scrambled it to make a type specimen book",
                                fontWeight: FontWeight.w700,
                                size: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        if (widget.showhostsoc)
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: CustomText(
                                  text: "Host Society",
                                  fontWeight: FontWeight.bold,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        if (widget.showhostsoc)
                          SocietyInfoCard(
                              society: widget.hostSociety, user: widget.user),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: CustomText(
                                text: "Host",
                                fontWeight: FontWeight.bold,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              changeScreen(
                                  context,
                                  ShowUserProfile(
                                    userModel: widget.eventhost,
                                    userSignUpModel: widget.user,
                                  ));
                            },
                            child: MemberInfo(user: widget.eventhost)),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: CustomText(
                                text: "Who's Going ?",
                                fontWeight: FontWeight.bold,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Container(
                            height: height * 0.07,
                            child: GestureDetector(
                              onTap: () {
                                changeScreen(
                                    context,
                                    ViewEventFollowers(
                                      user: widget.user,
                                      eventfollowers: widget.eventfollowers,
                                    ));
                              },
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.eventfollowers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      child: Center(
                                    child: ClipOval(
                                      child: CircleAvatar(
                                          radius: 25,
                                          child: Image.asset('images/7.jpg')
                                          // FadeInImage.memoryNetwork(
                                          //   placeholder: kTransparentImage,
                                          //   image: userprovider
                                          //       .eventparticipants[index].profileimage,
                                          // ),
                                          ),
                                    ),
                                  ));
                                },
                              ),
                            ),
                          ),
                        )
                      ]);
                    }))));
  }
}
