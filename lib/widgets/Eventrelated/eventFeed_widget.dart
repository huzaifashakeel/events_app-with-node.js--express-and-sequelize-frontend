import 'dart:ui';
import 'package:events_app/apiModels/EventModel.dart';
import 'package:events_app/apiModels/societyModel.dart';
import 'package:events_app/apiModels/userModel.dart';
import 'package:events_app/apiModels/usersignUpModel.dart';
import 'package:events_app/apicall/becend_functions_call.dart';
import 'package:events_app/helpers/screen_nav.dart';
import 'package:events_app/screens/Details/eventDetails.dart';
import 'package:events_app/screens/mainPages/loading.dart';
import 'package:events_app/widgets/customtext.dart';
import 'package:flutter/material.dart';

class EventFeed extends StatefulWidget {
  final bool showhostsoc;
  final ApiEventModel event;
  final ApiUserSignUpModel user;

  EventFeed(
      {required this.event, required this.user, required this.showhostsoc});

  @override
  _EventFeedState createState() => _EventFeedState();
}

class _EventFeedState extends State<EventFeed> {
  int likes = 0;
  Beckend apicall = new Beckend();
  bool isadmin = false;
  @override
  Widget build(BuildContext context) {
    print(widget.event.hostEmail);
    print(widget.user.email);

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: _height * 0.35,
                  width: _width * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    //image: DecorationImage(image: AssetImage(widget.image), fit: BoxFit.cover)
                  ),
                  child: Stack(
                    children: [
                      Loading(),
                      GestureDetector(
                          child: Image.asset(
                        "images/1.jpg",
                        fit: BoxFit.cover,
                        height: _height * 0.35,
                      )
                          // FadeInImage.memoryNetwork(
                          //   placeholder: kTransparentImage,
                          //   image: widget.event.image,
                          //   fit: BoxFit.fill,
                          //   height: _height * 0.35,
                          //   width: _width * 0.95,
                          // ),
                          ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (widget.user.isvarified) {
                      if (widget.event.hostEmail == widget.user.email) {
                        print("i am admin");
                        isadmin = true;
                      }
                      ApiUserModel host = await apicall.loadEventhost(
                          hostemail: widget.event.hostEmail,
                          token: widget.user.token);
                      ApiSocietyModel hostsociety = await apicall.getsociety(
                          id: widget.event.societyid, token: widget.user.token);

                      List<ApiUserModel> eventfollowers =
                          await apicall.geteventMembers(
                              id: widget.event.eventid,
                              token: widget.user.token);

                      changeScreen(
                          context,
                          EventDetails(
                            event: widget.event,
                            eventhost: host,
                            eventfollowers: eventfollowers,
                            showhostsoc: widget.showhostsoc,
                            user: widget.user,
                            hostSociety: hostsociety,
                            isadmin: isadmin,
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "You must complete your information to view Event")));
                    }
                  },
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Container(
                        width: _width * 0.95,
                        height: _height * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: _height * 0.35,
                  width: _width * 0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Chip(
                            label: Text(
                              widget.event.isonline ? "Online" : "Onsite",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black87,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                      Padding(
                        //get screen size and adjust pedding (later)
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: _height * 0.10,
                            width: _width * 0.16,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.black87),
                            child: Center(
                              child: CustomText(
                                text: "July \n " +
                                    widget.event.eventDate.substring(8, 10),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: widget.event.name,
                        fontWeight: FontWeight.bold,
                        size: 17,
                        color: Colors.white,
                      ),
                      CustomText(
                        text: widget.event.address,
                        fontWeight: FontWeight.normal,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              leading:
                  CircleAvatar(backgroundImage: AssetImage("images/7.jpg")),
              title: Text(
                widget.event.adminName,
              ),
              subtitle: Text(
                widget.event.hostsociety,
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    likes++;
                  });
                },
                child: Container(
                  width: 60,
                  child: Row(
                    children: [
                      Icon(Icons.thumb_up),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("$likes"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
